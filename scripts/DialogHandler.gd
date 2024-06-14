
class_name DialogHandler
extends Node

@export var locations : Array[Location]
@export var monsterDialogs : Array[String]
@export var generalDialogs : Array[String]

var timer : int

func _ready():
	Dialogic.signal_event.connect(eventFired)

func startEvent():
	var dE = DialogEvent.new()
	dE.init(locations)
	print(dE.location.locationName)
	Dialogic.VAR.timer = 2
	Dialogic.VAR.location = dE.location.locationName

func endEvent():
	print("cut phone")

func eventFired(st):
	match (st):
		"startEvent":
			startEvent()
