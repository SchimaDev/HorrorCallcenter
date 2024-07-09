extends Node

var chosenWordDictionary
var chosenWordDialogue
var chosenMonster

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func handle_url_tag_clicked(name: String) -> void:
	
	chosenMonster = "Parasite"
	chosenWordDictionary = ["person"]
	
	chosenWordDialogue = name
	
	if chosenWordDictionary.has(chosenWordDialogue):
		Dialogic.VAR._MonsterSelect.set(chosenMonster, true)
		var v = chosenMonster + "." + chosenWordDialogue
		Dialogic.VAR.set_variable(v, true)

func handle_Encyclopedia_url_tag_clicked(name: String) -> void:
	var n = name.split(".")
	chosenMonster = n[0]
	n.remove_at(0)
	chosenWordDictionary = n
	
	if chosenWordDictionary.has(chosenWordDialogue):
		var v = chosenMonster + "." + chosenWordDialogue
		Dialogic.VAR.set_variable(v, true)

