extends Camera3D

@export var targetCamera: Camera3D
var deskCameraDefaultRotation: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("AA")
	CameraShifter.transition_3d_started.connect(_on_transition_3d_started)
	CameraShifter.transition_3d_finished.connect(_on_transition_3d_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if get_viewport().get_camera_3d() == self:
		if event is InputEventMouseButton:
			CameraShifter.transition_to_requested_camera_3d(self, targetCamera, 1)

func _on_transition_3d_started(from: Camera3D, to: Camera3D, duration: float):
	if to == self:
		get_parent().get_node("UI/Crosshair").visible = false

func _on_transition_3d_finished(from: Camera3D, to: Camera3D, duration: float):
	if to == self:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)


