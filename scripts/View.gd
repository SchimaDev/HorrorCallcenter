extends StaticBody3D

@onready var shader = $Mesh.mesh.surface_get_material(0).next_pass
@onready var camera = $Camera
@onready var ui = $UI
var targeted = false: 
	set(val):
		targeted = val
		if targeted and Dialogic.VAR.Tutorial.computerUnlocked:
			shader.set_shader_parameter("strength", 0.2)
		else:
			shader.set_shader_parameter("strength", 0)


func _input(event: InputEvent) -> void:
	if targeted and event is InputEventMouseButton and Dialogic.VAR.Tutorial.computerUnlocked:
		openBookView()

func openBookView():
	if get_viewport().get_camera_3d() != camera:
		FmodEventMessenger.openBook.start()
		camera.switchView()
		%AnimationPlayer.play("pickup_book")
		
		# check if tutorial variable has been set
		if !Dialogic.VAR.Tutorial.tutorialCompleted:
			if !Dialogic.VAR.Tutorial.computerClicked:
				Dialogic.VAR.Tutorial.computerClicked = true
				Dialogic.start_timeline("Supervisor_01", "computerClicked")
				return
			if !Dialogic.VAR.Tutorial.bookClicked:
				Dialogic.VAR.Tutorial.bookClicked = true
				Dialogic.start_timeline("Supervisor_01", "bookClicked")
				return

func disableShader():
	$Mesh.mesh.surface_get_material(0).next_pass = null
