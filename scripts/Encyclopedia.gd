class_name Encyclopedia
extends Node3D

@onready var animation_player = $AnimationPlayer
@export var tex : Array[StandardMaterial3D]
@onready var cube = $Armature_001/Skeleton3D/Cube_001

var page = -1

func _ready():
	pass

func _on_rich_text_label_meta_clicked(meta):
	ClickTextEventHandler.handle_Encyclopedia_url_tag_clicked(meta.split("."))

func _process(delta):
	if  Input.is_action_just_pressed("book_test"):
		if page >= tex.size()-1:
			page = tex.size()-1
		else:
			page += 1
			animation_player.stop()
			cube.set_surface_override_material(1, tex[page])
			animation_player.play("Armature_001Action")
	if  Input.is_action_just_pressed("book_test_2"):
		if page <= -1:
			page = -1
		else:
			animation_player.seek(2,5)
			cube.set_surface_override_material(1, tex[page])
			animation_player.play_backwards("Armature_001Action")
			page -= 1
