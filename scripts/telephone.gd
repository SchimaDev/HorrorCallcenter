extends Node3D

var incomingCall = ""
# dialog_name : question_limit
var callQueue = [{"Supervisor_01": 500}, {"Sincubus_01": 50}, {"Jonny_01": 7}, {"Lucia_01": 5}]

@onready var popup = $Popup
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
			incomingCall = {"" : 0}
			hidePopup(0.5)
			# delete doubled history in monitor
			if history_parent.get_child_count() > 1:
				history_parent.get_child(1).clear_history_log()
			
			Dialogic.end_timeline()
			Dialogic.VAR.reset()

			Dialogic.VAR.set_variable("Tutorial.deskViewUnlocked", true)
			Dialogic.VAR.set_variable("Tutorial.bookUnlocked", true)
			Dialogic.VAR.set_variable("Tutorial.computerUnlocked", true)
			Dialogic.VAR.set_variable("Tutorial.tutorialCompleted", true)

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
			incomingCall = {"end" : 0}
			showPopup()
			await get_tree().create_timer(4).timeout
			hidePopup(2)
			await get_tree().create_timer(1).timeout
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

func showPopup():
	popup.set_self_modulate(Color(Color.WHITE, 0))
	var tween = get_tree().create_tween()
	tween.tween_property(popup, "self_modulate", Color(Color.WHITE, 1), 0.5).set_ease(Tween.EASE_IN)

func hidePopup(time):
	var tween = get_tree().create_tween()
	tween.tween_property(popup, "self_modulate", Color(Color.WHITE, 0), time).set_ease(Tween.EASE_IN)
