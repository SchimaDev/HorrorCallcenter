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


func _input(event: InputEvent) -> void:
	if targeted and event is InputEventMouseButton:
		openBookView()

func openBookView():
	if get_viewport().get_camera_3d() != camera:
		FmodEventMessenger.openBook.start()
		camera.switchView()
		%AnimationPlayer.play("pickup_book")
