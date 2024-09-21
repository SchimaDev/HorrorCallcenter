extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("fade_in")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	$"DeskCamera/Highlight Ray".enabled = true

func _on_telephone_end_day():
	$Monitor.disableShader()
	$AnimationPlayer.play("fade_in_between")
