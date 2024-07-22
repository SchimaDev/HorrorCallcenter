extends Node3D

# Used for checking if the mouse is inside the Area3D.
var is_mouse_inside = false
# The last processed input touch/mouse event. To calculate relative movement.
var last_event_pos2D = null
# The time of the last event in seconds since engine start.
var last_event_time: float = -1.0

#func _on_rich_text_label_meta_clicked(meta):
	#ClickTextEventHandler.handle_Encyclopedia_url_tag_clicked(meta)
@onready var node_viewport = $SubViewport
@onready var node_quad = $Armature_001/Skeleton3D/Cube_001
@onready var node_area = $Armature_001/Skeleton3D/Cube_001/Area3D
@onready var animation_player = $AnimationPlayer
@onready var view = $SubViewport/GUI/Control

var page = 0
var p1 = [0.852, 0.49, 1.68, 0.60]
var p2 = [2.6, 1.48, 1.7, 0.60]
var UIscale = p1

func _ready():
	node_area.mouse_entered.connect(_mouse_entered_area)
	node_area.mouse_exited.connect(_mouse_exited_area)
	node_area.input_event.connect(_mouse_input_event)
	view.turnNextPage.connect(nextPage)
	view.turnPrevPage.connect(prevPage)

func nextPage():
	if page >= 7:
		page = 7
	else:
		page += 1
		view.showPages(page)
		animation_player.play("Armature_001Action")
		FmodEventMessenger.pageTurn.start();
		UIscale = p2	

func prevPage():
	if page <= 0:
		page = 0
	else:
		view.showPages(page)
		animation_player.play_backwards("Armature_001Action")
		FmodEventMessenger.pageTurn.start();
		UIscale = p1
		page -= 1	

func _mouse_entered_area():
	is_mouse_inside = true


func _mouse_exited_area():
	is_mouse_inside = false


func _unhandled_input(event):
	# Check if the event is a non-mouse/non-touch event
	for mouse_event in [InputEventMouseButton, InputEventMouseMotion, InputEventScreenDrag, InputEventScreenTouch]:
		if is_instance_of(event, mouse_event):
			# If the event is a mouse/touch event, then we can ignore it here, because it will be
			# handled via Physics Picking.
			return
	node_viewport.push_input(event)


func _mouse_input_event(_camera: Camera3D, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int):
	# Get mesh size to detect edges and make conversions. This code only support PlaneMesh and QuadMesh.
	var quad_mesh_size = node_quad.mesh.get_aabb().size
	quad_mesh_size.x *= UIscale[0]
	quad_mesh_size.y *= UIscale[2]
	#quad_mesh_size.z *= 1

	# Event position in Area3D in world coordinate space.
	var event_pos3D = event_position

	# Current time in seconds since engine start.
	var now: float = Time.get_ticks_msec() / 1000.0

	# Convert position to a coordinate space relative to the Area3D node.
	# NOTE: affine_inverse accounts for the Area3D node's scale, rotation, and position in the scene!
	event_pos3D = node_quad.global_transform.affine_inverse() * event_pos3D

	var event_pos2D: Vector2 = Vector2()

	if is_mouse_inside:
		# Convert the relative event position from 3D to 2D.
		event_pos2D = Vector2(event_pos3D.y, event_pos3D.x)

		# Right now the event position's range is the following: (-quad_size/2) -> (quad_size/2)
		# We need to convert it into the following range: -0.5 -> 0.5
		event_pos2D.x /= quad_mesh_size.y
		event_pos2D.y /= quad_mesh_size.x
		# Then we need to convert it into the following range: 0 -> 1
		event_pos2D.x += 0.5
		event_pos2D.y += 0.5

		# Finally, we convert the position to the following range: 0 -> viewport.size
		event_pos2D.x *= node_viewport.size.x * UIscale[3]
		event_pos2D.y *= node_viewport.size.y * UIscale[1]
		# We need to do these conversions so the event's position is in the viewport's coordinate system.

	elif last_event_pos2D != null:
		# Fall back to the last known event position.
		event_pos2D = last_event_pos2D

	# Set the event's position and global position.
	event.position = event_pos2D
	if event is InputEventMouse:
		event.global_position = event_pos2D

	# Calculate the relative event distance.
	if event is InputEventMouseMotion or event is InputEventScreenDrag:
		# If there is not a stored previous position, then we'll assume there is no relative motion.
		if last_event_pos2D == null:
			event.relative = Vector2(0, 0)
		# If there is a stored previous position, then we'll calculate the relative position by subtracting
		# the previous position from the new position. This will give us the distance the event traveled from prev_pos.
		else:
			event.relative = event_pos2D - last_event_pos2D
			event.velocity = event.relative / (now - last_event_time)

	# Update last_event_pos2D with the position we just calculated.
	last_event_pos2D = event_pos2D

	# Update last_event_time to current time.
	last_event_time = now

	# Finally, send the processed input event to the viewport.
	node_viewport.push_input(event)
