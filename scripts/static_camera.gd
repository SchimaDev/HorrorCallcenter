extends Camera3D

@export var targetCamera: Camera3D
@export var ui: Control
var deskCameraDefaultRotation: Vector3

signal view_entered
signal view_exited

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CameraShifter.transition_3d_started.connect(_on_transition_3d_started)
	CameraShifter.transition_3d_finished.connect(_on_transition_3d_finished)

func _on_transition_3d_started(_from: Camera3D, to: Camera3D, _duration: float):
	if to == self:
		get_tree().current_scene.get_node("UI/Crosshair").visible = false

func _on_transition_3d_finished(_from: Camera3D, to: Camera3D, _duration: float):
	if to == self:
		ui.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _on_exit_button_pressed() -> void:
		FmodEventMessenger.closeBook.start()
		CameraShifter.transition_to_requested_camera_3d(self, targetCamera, 1)
		ui.visible = false
		$"../../AnimationPlayer".play_backwards("pickup_book")
		emit_signal("view_exited")

func _input(_event):
	if Input.is_action_just_pressed("exit_view") && ui.visible:
		_on_exit_button_pressed()

func switchView():
	CameraShifter.transition_to_requested_camera_3d(get_viewport().get_camera_3d(), self, 1)
	emit_signal("view_entered")
