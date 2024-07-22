extends Node

var pageTurn: FmodEvent = null
var ceilingLightAmbience: FmodEvent = null

# drone sounds
var drone1: FmodEvent = null
var drone2: FmodEvent = null

# monster sounds
var monsterAnalogueLow: FmodEvent = null
var monsterAnalogueHigh: FmodEvent = null
var monsterOozeLow: FmodEvent = null
var monsterOozeHigh: FmodEvent = null
var monsterScreamerLow: FmodEvent = null
var monsterScreamerHigh: FmodEvent = null
var monsterMumbling: FmodEvent = null
var monsterParasiteFootsteps: FmodEvent = null


func _ready():
	loadSoundEvents()

func loadSoundEvents():
	pageTurn = FmodServer.create_event_instance("event:/Glossary/TurnPage")
	ceilingLightAmbience = FmodServer.create_event_instance("event:/Ambience/CeilingLightAmbience")
	
	drone1 = FmodServer.create_event_instance("event:/Ambience/DroneSounds/Drone1")
	drone2 = FmodServer.create_event_instance("event:/Ambience/DroneSounds/Drone2")
	
	monsterAnalogueLow = FmodServer.create_event_instance("event:/Monster/AnalogueLow")
	monsterAnalogueHigh = FmodServer.create_event_instance("event:/Monster/AnalogueHigh")
	monsterOozeLow = FmodServer.create_event_instance("event:/Monster/OozeLow")
	monsterOozeHigh = FmodServer.create_event_instance("event:/Monster/OozeHigh")
	monsterScreamerLow = FmodServer.create_event_instance("event:/Monster/ScreamerLow")
	monsterScreamerHigh = FmodServer.create_event_instance("event:/Monster/ScreamerHigh")
	monsterMumbling = FmodServer.create_event_instance("event:/Monster/Mumbling")
	monsterParasiteFootsteps = FmodServer.create_event_instance("event:/Monster/ParasiteFootsteps")
	
func setAmbienceIntensity(level: int):
	drone1.set_parameter_by_name("DroneAmbienceLevel", level)
	drone2.set_parameter_by_name("DroneAmbienceLevel", level)

func playFootsteps():
	monsterParasiteFootsteps.start()

func playMumbling():
	monsterMumbling.start()

func setAmbienceIntensityLow():
	setAmbienceIntensity(0)

func setAmbienceIntensityMid():
	setAmbienceIntensity(1)

func setAmbienceIntensityHigh():
	setAmbienceIntensity(2)
	
func playDroneSound():
	drone1.start()
	
func stopDroneSound():
	drone1.stop(0);
