class_name Encyclopedia
extends Node3D

@onready var animation_player = $AnimationPlayer

func _ready():
	pass

func _on_rich_text_label_meta_clicked(meta):
	ClickTextEventHandler.handle_Encyclopedia_url_tag_clicked(meta)

func _process(delta):
	if  Input.is_action_just_pressed("book_test"):
		animation_player.play("Armature_001Action")
	if  Input.is_action_just_pressed("book_test_2"):
		animation_player.stop(false);
