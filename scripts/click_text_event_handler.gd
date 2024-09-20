extends Node

var chosenWordDictionary = []
var chosenWordDialogue = ""
var chosenMonster = ""
var reloadQuestions = false
var dialog = ""
var monsterSelect = false

signal chosenWordDialogueChanged(word)
signal chosenWordDictionaryChanged(monster, dictionary)

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
	chosenWordDialogueChanged.emit(chosenWordDialogue)
	compareWords()

func handle_Encyclopedia_url_tag_clicked(clue: String) -> void:
	print(clue)
	var n = clue.split(", ")
	chosenMonster = n[0]
	
	n.remove_at(0)
	chosenWordDictionary = n
	
	chosenWordDictionaryChanged.emit(chosenMonster, chosenWordDictionary)
	compareWords()

# compare clicked clue from dialog and book
func compareWords():
	# exception for asking one of the basic question -> selected clue from dialog ignored
	# connecting ANY dialog clue to "hallucinations" -> any observation could be a hallucination of the caller
	if chosenMonster == "_Basic" or (chosenWordDictionary.has("hallucinations") and chosenWordDialogue != ""):
		chosenWordDialogue = chosenWordDictionary[0]
	
	# exception for clicking easteregg clue
	if chosenWordDialogue == "egg":
		chosenWordDictionary[0] = chosenWordDialogue
		chosenMonster = "_Basic"
		Dialogic.VAR.timer += 1
	
	# confirm choice of which monster it is
	if chosenMonster == "_MonsterSelect" && monsterSelect:
		Dialogic.start_timeline(dialog, chosenWordDictionary[0])
		return
	
	# entering Monster Selection mode
	if chosenWordDictionary.has("monsterSelect"):
		monsterSelect = !monsterSelect
		Dialogic.VAR._Basic.monsterSelect = monsterSelect
		flushClues()
	# compare clicked clues and set according variable
	elif chosenWordDictionary.has(chosenWordDialogue):
		var v = chosenMonster + "." + chosenWordDialogue
		Dialogic.VAR.set_variable(v, true)
		Dialogic.VAR._MonsterSelect.set(chosenMonster, true)
		flushClues()
	
	# skip in-between dialog waiting time
	if reloadQuestions:
			Dialogic.start_timeline(dialog, "question")
			Dialogic.VAR.timer += 1

func flushClues():
	chosenWordDialogue = ""
	chosenWordDictionary.clear()
	chosenWordDictionary.append("")
	chosenMonster = ""

