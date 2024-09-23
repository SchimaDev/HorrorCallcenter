extends Node3D

@onready var shader1 = $paper.get_surface_override_material(0)
@onready var shader2 = $paper2.get_surface_override_material(0)
@onready var shader3 = $paper3.get_surface_override_material(0)
@onready var shader4 = $paper4.get_surface_override_material(0)
const PAGE_TEXTURE = preload("res://art/3D/bookmesh/pages/page_texture.png")
const PAGE_TEXTURE_EXAMPLE = preload("res://art/3D/bookmesh/pages/page_texture_EXAMPLE.png")

var targeted = false: 
	set(val):
		targeted = val
		if targeted:
			shader1.albedo_color = Color.WHITE
			shader2.albedo_color = Color.WHITE
			shader3.albedo_color = Color.WHITE
			shader4.albedo_color = Color.WHITE
		else:
			shader1.albedo_color = Color.ANTIQUE_WHITE
			shader2.albedo_color = Color.ANTIQUE_WHITE
			shader3.albedo_color = Color.ANTIQUE_WHITE
			shader4.albedo_color = Color.ANTIQUE_WHITE
signal changeView
var page = 0

func _ready():
	shader1.albedo_color = Color.ANTIQUE_WHITE
	shader2.albedo_color = Color.ANTIQUE_WHITE
	shader3.albedo_color = Color.ANTIQUE_WHITE
	shader4.albedo_color = Color.ANTIQUE_WHITE

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
		page += 1
		var flip = "flip"+ str(page)
		%AnimationPlayer.play(flip)
		FmodEventMessenger.turnPage.start();

func prevPage():
	if page <= 0:
		return
	else:
		var flip = "flip"+ str(page)
		page -= 1
		%AnimationPlayer.play_backwards(flip)
		FmodEventMessenger.turnPage.start();

func _on_visibility_changed():
	$UI.visible = visible

func showResults(results):
	shader1.albedo_texture = PAGE_TEXTURE if results[1] else PAGE_TEXTURE_EXAMPLE
	shader2.albedo_texture = PAGE_TEXTURE if results[2] else PAGE_TEXTURE_EXAMPLE
	shader3.albedo_texture = PAGE_TEXTURE if results[3] else PAGE_TEXTURE_EXAMPLE
