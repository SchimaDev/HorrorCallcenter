extends Node3D

@onready var shader1 = $paper.get_surface_override_material(0)
@onready var shader2 = $paper2.get_surface_override_material(0)
@onready var shader3 = $paper3.get_surface_override_material(0)
var targeted = false: 
	set(val):
		targeted = val
		if targeted:
			shader1.albedo_color = Color.WHITE
			shader2.albedo_color = Color.WHITE
			shader3.albedo_color = Color.WHITE
		else:
			shader1.albedo_color = Color.ANTIQUE_WHITE
			shader2.albedo_color = Color.ANTIQUE_WHITE
			shader3.albedo_color = Color.ANTIQUE_WHITE
signal changeView

func _ready():
	shader1.albedo_color = Color.ANTIQUE_WHITE
	shader2.albedo_color = Color.ANTIQUE_WHITE
	shader3.albedo_color = Color.ANTIQUE_WHITE

func _input(event: InputEvent) -> void:
	if targeted and event is InputEventMouseButton:
			changeView.emit()
