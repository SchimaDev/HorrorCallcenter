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
var page = 1

func _ready():
	shader1.albedo_color = Color.ANTIQUE_WHITE
	shader2.albedo_color = Color.ANTIQUE_WHITE
	shader3.albedo_color = Color.ANTIQUE_WHITE

func _input(event: InputEvent) -> void:
	if targeted and event is InputEventMouseButton:
			changeView.emit()
	if $UI/Button.visible:
		if Input.is_action_just_pressed("next"):
			nextPage()
		if Input.is_action_just_pressed("prev"):
			prevPage()

func nextPage():
	if page >= 3:
		return
	else:
		var flip = "flip"+ str(page)
		page += 1
		%AnimationPlayer.play(flip)
		FmodEventMessenger.turnPage.start();

func prevPage():
	if page <= 1:
		return
	else:
		page -= 1
		var flip = "flip"+ str(page)
		%AnimationPlayer.play_backwards(flip)
		FmodEventMessenger.turnPage.start();

func _on_visibility_changed():
	$UI.visible = visible
