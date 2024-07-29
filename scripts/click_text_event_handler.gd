extends Node

var chosenWordDictionary = []
var chosenWordDialogue = ""
var chosenMonster = ""
var reloadQuestions = false
var dialog = ""
var monsterSelect = false

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
	
	if chosenMonster == "_Basic":
		chosenWordDialogue = chosenWordDictionary[0]
	
	if chosenMonster == "_MonsterSelect" && monsterSelect:
		Dialogic.start_timeline(dialog, chosenWordDictionary[0])
		return
	
	if chosenWordDictionary.has("monsterSelect"):
		monsterSelect = !monsterSelect
		Dialogic.VAR._Basic.monsterSelect = monsterSelect
		flushClues()
	elif chosenWordDictionary.has(chosenWordDialogue):
		var v = chosenMonster + "." + chosenWordDialogue
		Dialogic.VAR.set_variable(v, true)
		Dialogic.VAR._MonsterSelect.set(chosenMonster, true)
		flushClues()
	
	if reloadQuestions:
			Dialogic.start_timeline(dialog, "question")
			Dialogic.VAR.timer += 1

func flushClues():
	chosenWordDialogue = ""
	chosenWordDictionary.clear()
	chosenWordDictionary.append("")
	chosenMonster = ""

