extends FmodEventEmitter3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turnOn()

func turnOn():
	self["event_parameter/CRT On/value"] = 1;

func turnOff():
	self["event_parameter/CRT On/value"] = 0;
