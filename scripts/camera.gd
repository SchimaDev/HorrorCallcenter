extends Camera3D

@export var mouseSpeed: float = 300.0
@export var targetCamera: Camera3D
var defaultRotation: Vector3

var lookAngle: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	defaultRotation = rotation
	lookAngle = Vector2(defaultRotation.y, defaultRotation.x)
	CameraShifter.transition_3d_started.connect(_on_transition_3d_started)
	CameraShifter.transition_3d_finished.connect(_on_transition_3d_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_viewport().get_camera_3d() == self:
		lookAngle.y = clamp(lookAngle.y, PI / -4, PI / 4)
		lookAngle.x = clamp(lookAngle.x, PI + PI / -1.5, PI + PI / 1.5)
		set_rotation(Vector3(lookAngle.y, lookAngle.x, 0))

func _input(event: InputEvent) -> void:
	if get_viewport().get_camera_3d() == self:
		if event is InputEventMouseMotion:
			lookAngle -= event.relative / mouseSpeed
		#if event is InputEventMouseButton:
			#CameraShifter.transition_to_requested_camera_3d(self, targetCamera, 1)
			#rotation = defaultRotation
			#lookAngle = Vector2(defaultRotation.y, defaultRotation.x)

func _on_transition_3d_started(from: Camera3D, to: Camera3D, duration: float):
	if to == self:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_transition_3d_finished(from: Camera3D, to: Camera3D, duration: float):
	if to == self:
		get_parent().get_node("UI/Crosshair").visible = true
