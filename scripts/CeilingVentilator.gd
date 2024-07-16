extends MeshInstance3D

#FMOD events
var event: FmodEvent = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	createAndStartFmodEvent()

func createAndStartFmodEvent():
	event = FmodServer.create_event_instance("event:/Ambience/CeilingLightAmbience")
	event.set_3d_attributes(self.global_transform)
	event.start()

