extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_mouse_entered() -> void:
	print("inside")


func _on_area_3d_mouse_exited() -> void:
	print("outside")
