extends Node

var pageTurn: FmodEvent = null
var ceilingLightAmbience: FmodEvent = null

# drone sounds
var drone1: FmodEvent = null
var drone2: FmodEvent = null

# monster sounds
var monsterAnalogue: FmodEvent = null
var monsterOoze: FmodEvent = null
var monsterScreamer: FmodEvent = null


func _ready():
	loadSoundEvents()

func loadSoundEvents():
	pageTurn = FmodServer.create_event_instance("event:/Glossary/TurnPage")
	ceilingLightAmbience = FmodServer.create_event_instance("event:/Ambience/CeilingLightAmbience")
	
	drone1 = FmodServer.create_event_instance("event:/Ambience/DroneSounds/Drone1")
	drone2 = FmodServer.create_event_instance("event:/Ambience/DroneSounds/Drone2")
	
	monsterAnalogue = FmodServer.create_event_instance("event:/Monster/Analogue")
	monsterOoze = FmodServer.create_event_instance("event:/Monster/Ooze")
	monsterScreamer = FmodServer.create_event_instance("event:/Monster/Screamer")
