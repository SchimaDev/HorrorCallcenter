@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("CameraShifter", "res://addons/camera-shifter/global_camera_transition.tscn")


func _exit_tree():
	remove_autoload_singleton("CameraShifter")
