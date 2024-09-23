extends Node3D

var incomingCall = ""
# dialog_name : question_limit
var callQueue = [{"Supervisor_01": 500}, {"Sincubus_01": 50}, {"Jonny_01": 7}, {"Lucia_01": 5}]

@onready var history_parent = $"../GUIPanel3D/ScreenViewport"
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
	Dialogic.VAR.timer = incomingCall.values()[0]

func setupRingingPhone() -> void:
	FmodEventMessenger.ringingPhone.set_3d_attributes(self.global_transform)
	FmodEventMessenger.playRingingPhone()

func _input(event: InputEvent) -> void:
	if targeted and event.is_action_released("left_mouse"):
		
		if incomingCall.keys()[0] == "end":
			if history_parent.get_child_count() > 1:
				history_parent.get_child(1).clear_history_log()
			
			Dialogic.end_timeline()
			Dialogic.VAR.reset()

			Dialogic.VAR.set_variable("Tutorial.deskViewUnlocked", true)
			Dialogic.VAR.set_variable("Tutorial.bookUnlocked", true)
			Dialogic.VAR.set_variable("Tutorial.computerUnlocked", true)
			Dialogic.VAR.set_variable("Tutorial.tutorialCompleted", true)

			incomingCall = {"" : 0}
			animation_player.play_backwards("pickup_phone")
			# TODO stop phone beeping
			FmodEventMessenger.stopHangUpPhoneCaller()
			FmodEventMessenger.playHangUpPhonePlayer()
			# queue next call after short delay
			await get_tree().create_timer(5).timeout
			if callQueue.size() > 0:
				incomingCall = callQueue.pop_front()
				Dialogic.VAR.timer = incomingCall.values()[0]
				FmodEventMessenger.playRingingPhone()
				
		elif incomingCall.keys()[0] == "inCall":
			# TODO popou message ask player if they really want to end call now
			# click phone again to confirm
			incomingCall = {"end" : 0}
			print("u sure you wanna end the call now?")
			await get_tree().create_timer(5).timeout
			incomingCall = {"inCall" : 0}
			
		elif incomingCall.keys()[0] != "":
			animation_player.play("pickup_phone")
			FmodEventMessenger.stopRingingPhone()
			Dialogic.start(incomingCall.keys()[0])
			ClickTextEventHandler.dialog = incomingCall.keys()[0]
			await get_tree().create_timer(1).timeout
			incomingCall = {"inCall" : 0}

func _on_dialogic_signal(argument):
	if argument == "callEnded":
		incomingCall = {"end" : 0}
