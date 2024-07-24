extends Node

var chosenWordDictionary = []
var chosenWordDialogue = ""
var chosenMonster = ""
var reloadQuestions = false
var dialog = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "ask":
		reloadQuestions = true
	elif argument == "answer":
		reloadQuestions = false

func handle_url_tag_clicked(clue: String) -> void:
	print(clue)
	chosenWordDialogue = clue
	compareWords()

func handle_Encyclopedia_url_tag_clicked(clue: String) -> void:
	print(clue)
	var n = clue.split(", ")
	chosenMonster = n[0]
	
	n.remove_at(0)
	chosenWordDictionary = n
	
	compareWords()

func compareWords():
	if chosenWordDictionary.has("hallucinations"):
		chosenWordDialogue = "hallucinations"
	if chosenWordDictionary.has(chosenWordDialogue):
		var v = chosenMonster + "." + chosenWordDialogue
		Dialogic.VAR.set_variable(v, true)
		Dialogic.VAR._MonsterSelect.set(chosenMonster, true)
		if reloadQuestions:
			Dialogic.start_timeline(dialog, "question")
			Dialogic.VAR.timer += 1

