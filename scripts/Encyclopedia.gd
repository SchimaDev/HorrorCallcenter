class_name Encyclopedia
extends Sprite2D

const outline  = preload("res://art/outline.gdshader")
@onready var page = $"../Page"
#signal openBook

func _on_area_2d_mouse_entered() -> void:
	self.material.shader = outline


func _on_area_2d_mouse_exited() -> void:
	self.material.shader = null


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			page.visible = true
			get_viewport().set_input_as_handled()


func _on_rich_text_label_meta_clicked(meta):
	ClickTextEventHandler.handle_Encyclopedia_url_tag_clicked(meta)
