extends RayCast3D

var lookingAt = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var coll = get_collider()
	
	if lookingAt != coll:
		# check if collider isn't null and variable "targeted" exists in collided object
		if coll != null and "targeted" in coll:
			coll.targeted = true
		if lookingAt != null and "targeted" in lookingAt:
			lookingAt.targeted = false
		lookingAt = coll
