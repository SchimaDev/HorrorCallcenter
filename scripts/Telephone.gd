class_name Telephone
extends Sprite2D

const outline  = preload("res://art/outline.gdshader")

signal startCall

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	self.material.shader = outline


func _on_area_2d_mouse_exited() -> void:
	self.material.shader = null

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			startCall.emit()
			get_viewport().set_input_as_handled()
