extends Node

var chosenWordDictionary: String
var chosenWordDialogue: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func handle_url_tag_clicked(name: String) -> void:
	chosenWordDialogue = name
	if chosenWordDialogue == chosenWordDictionary:
		Dialogic.VAR.set(name, true)

func handle_Encyclopedia_url_tag_clicked(name: String) -> void:
	chosenWordDictionary = name
	if chosenWordDialogue == chosenWordDictionary:
		Dialogic.VAR.set(name, true)

