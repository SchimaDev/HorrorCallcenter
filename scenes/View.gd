extends StaticBody3D

@onready var shader = $Mesh.mesh.surface_get_material(0).next_pass
@onready var camera = $Camera
@onready var ui = $UI
var targeted = false: 
	set(val):
		targeted = val
		if targeted:
			shader.set_shader_parameter("strength", 0.2)
		else:
			shader.set_shader_parameter("strength", 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if targeted and get_viewport().get_camera_3d() != camera:
		if event is InputEventMouseButton:
			camera.switchView()
