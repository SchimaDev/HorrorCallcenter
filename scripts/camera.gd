extends Camera3D

@export var mouseSpeed: float = 300.0

var lookAngle: Vector2 = Vector2(PI,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lookAngle.y = clamp(lookAngle.y, PI / -4, PI / 4)
	lookAngle.x = clamp(lookAngle.x, PI + PI / -1.5, PI + PI / 1.5)
	set_rotation(Vector3(lookAngle.y, lookAngle.x, 0))
	print(lookAngle.x)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		lookAngle -= event.relative / mouseSpeed
