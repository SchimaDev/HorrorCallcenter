
class_name DialogHandler
extends Node

@export var locations : Array[Location]
@export var monsterDialogs : Array[String]
@export var generalDialogs : Array[String]

var timer : int

func startEvent():
	var dE = DialogEvent.new()
	dE.init(locations)
	
	Dialogic.start('monster_test')
	
	Dialogic.VAR.reset()
	Dialogic.VAR.timer = 5
	Dialogic.VAR.monster = " ".join(Monster.Type.find_key(dE.monster).split("_"))
	Dialogic.VAR.monsterState = Monster.State.find_key(dE.monsterState)
	Dialogic.VAR.location = dE.location.locationName

func endEvent():
	pass
