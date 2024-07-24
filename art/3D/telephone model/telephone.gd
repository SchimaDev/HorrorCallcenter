extends Node3D

var incomingCall = ""
var callQueue = ["Lucia_01", "Jonny_01"]

@onready var shader = $"RootNode/tel fijo".get_surface_override_material(0).next_pass
var targeted = false: 
	set(val):
		targeted = val
		if targeted:
			shader.set_shader_parameter("strength", 0.2)
		else:
			shader.set_shader_parameter("strength", 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	setupRingingPhone()
	incomingCall = callQueue.pop_front()

func setupRingingPhone() -> void:
	FmodEventMessenger.ringingPhone.set_3d_attributes(self.global_transform)
	FmodEventMessenger.playRingingPhone()

func _input(event: InputEvent) -> void:
	if targeted && incomingCall != "":
		if event is InputEventMouseButton:
			Dialogic.VAR.reset()
			FmodEventMessenger.stopRingingPhone()
			Dialogic.start(incomingCall)
			ClickTextEventHandler.dialog = incomingCall
			incomingCall = ""

func _on_dialogic_signal(argument):
	if argument == "callEnded":
		await get_tree().create_timer(5).timeout
		if callQueue.size() > 0:
			incomingCall = callQueue.pop_front()
			setupRingingPhone()
