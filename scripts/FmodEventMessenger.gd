extends Node

# ambience
var ceilingLightAmbience: FmodEvent = null

# book effects
var openBook: FmodEvent = null
var closeBook: FmodEvent = null
var turnPage: FmodEvent = null

# phone effects
var pickupPhone: FmodEvent = null
var hangupPhone: FmodEvent = null
var handOnPhone: FmodEvent = null
var ringingPhone: FmodEvent = null

# snapshots
var focus: FmodEvent = null

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

var prev_timer = 0;

func _ready():
	loadSoundEvents()
	
func _process(_delta):
	if prev_timer != Dialogic.VAR.timer :
		prev_timer = Dialogic.VAR.timer
		if(prev_timer == 10):
			setAmbienceIntensityLow()
		if(prev_timer == 6):
			setAmbienceIntensityMid()
		if(prev_timer == 3):
			setAmbienceIntensityHigh()

func loadSoundEvents():
	ceilingLightAmbience = FmodServer.create_event_instance("event:/Ambience/CeilingLightAmbience")
	
	turnPage = FmodServer.create_event_instance("event:/Glossary/TurnPage")
	openBook = FmodServer.create_event_instance("event:/Glossary/OpenBook")
	closeBook = FmodServer.create_event_instance("event:/Glossary/CloseBook")
	
	pickupPhone = FmodServer.create_event_instance("event:/Phone/PickupPhone")
	hangupPhone = FmodServer.create_event_instance("event:/Phone/HangupPhone")
	handOnPhone = FmodServer.create_event_instance("event:/Phone/HandOnPhone")
	ringingPhone = FmodServer.create_event_instance("event:/Phone/RingingPhone")
	
	focus = FmodServer.create_event_instance("snapshot:/Focus")
	
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
	
func playHandOnPhone():
	handOnPhone.start()
		
func playHangUpPhone():
	hangupPhone.start()
	
func playPickupPhone():
	pickupPhone.start()
	
func playRingingPhone():
	ringingPhone.start()
	
func stopRingingPhone():
	ringingPhone.stop(0)

func setAmbienceIntensityLow():
	setAmbienceIntensity(0)

func setAmbienceIntensityMid():
	setAmbienceIntensity(1)

func setAmbienceIntensityHigh():
	setAmbienceIntensity(2)
	
func playDroneSound():
	drone1.start()
	
func stopDroneSound():
	drone1.stop(0)
	
func startFocus():
	focus.start()

func stopFocus():
	focus.stop(0)
