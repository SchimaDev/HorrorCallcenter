class_name Location
extends Resource

@export var locationName : String
@export var noise : bool
@export var light : bool
@export var hidingSpots : Array[String]

var yes
var _no

func init(locationName: String, noise: bool, light: bool, hidingSpots: Array[String]):
	self.locationName = locationName
	self.noise = noise
	self.light = light
	self.hidingSpots = hidingSpots
