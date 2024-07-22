extends StaticBody3D

@onready var shader = $Mesh.mesh.surface_get_material(0).next_pass
var camera
var ui
var targeted = false: 
	set(val):
		targeted = val
		if targeted:
			shader.set_shader_parameter("strength", 0.2)
		else:
			shader.set_shader_parameter("strength", 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = find_child("Camera")
	ui = find_child("UI")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
