extends Node3D

var incomingCall = ""
var callQueue = ["Lucia_01", "Jonny_01"]

@onready var animation_player = $AnimationPlayer
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
	if targeted and event.is_action_released("left_mouse"):
		if incomingCall == "end":
			incomingCall = ""
			Dialogic.end_timeline()
			animation_player.play_backwards("pickup_phone")
			# TODO stop phone beeping
			FmodEventMessenger.playHangUpPhonePlayer()
			# queue next call after short delay
			await get_tree().create_timer(5).timeout
			if callQueue.size() > 0:
				incomingCall = callQueue.pop_front()
				FmodEventMessenger.playRingingPhone()
		elif incomingCall == "inCall":
			# TODO popou message ask player if they really want to end call now
			# click phone again to confirm
			incomingCall = "end"
			print("u sure you wanna end the call now?")
			await get_tree().create_timer(5).timeout
			incomingCall = "inCall"
		elif incomingCall != "":
			animation_player.play("pickup_phone")
			Dialogic.VAR.reset()
			FmodEventMessenger.stopRingingPhone()
			Dialogic.start(incomingCall)
			ClickTextEventHandler.dialog = incomingCall
			await get_tree().create_timer(1).timeout
			incomingCall = "inCall"

func _on_dialogic_signal(argument):
	if argument == "callEnded":
		incomingCall = "end"
