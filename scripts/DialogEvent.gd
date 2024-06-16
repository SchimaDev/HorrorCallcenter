
class_name DialogEvent
extends Node

var monster : Monster.Type
var monsterState : Monster.State
var location : Location
var person : Person

# Called when the node enters the scene tree for the first time.
func init(locations: Array):
	monster = _randomize(Monster.Type.keys())
	monsterState = _randomize(Monster.State.keys())
	location = locations[_randomize(locations)]

func _randomize(list: Array):
	return RandomNumberGenerator.new().randi_range(0, list.size()-1)



