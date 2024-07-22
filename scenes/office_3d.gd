extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("fade_in")
	#var layout = Dialogic.start('Jonny_01')
	#add_child(layout)
	#Dialogic.History.open_requested.emit()
	#var layout_copy = layout.duplicate()
	#$Screen/SubViewport.add_child(layout_copy)
	#var layout = Dialogic.get_layout_node()
	#layout.get_parent().remove_child(layout)
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$"DeskCamera/Highlight Ray".enabled = true
