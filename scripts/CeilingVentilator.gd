extends MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	createAndStartFmodEvent()

func createAndStartFmodEvent():
	FmodEventMessenger.ceilingLightAmbience.set_3d_attributes(self.global_transform)
	FmodEventMessenger.ceilingLightAmbience.start()

