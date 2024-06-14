class_name Person
extends Resource

@export var personName : String
@export var voice : DialogicCharacter
@export_range(1, 10)
var stressLevel: int
@export_range(1, 10)
var answerThreshold: int

func init(personName: String, voice: DialogicCharacter, stressLevel: int, answerThreshold: int):
	self.personName = personName
	self.voice = voice
	self.stressLevel = clamp(stressLevel, 1, 10)
	self.answerThreshold = clamp(answerThreshold, 1, 10)


