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
	elif argument == "timeout":
		monsterSelect = true

func handle_url_tag_clicked(clue: String) -> void:
	print(clue)
	chosenWordDialogue = clue
	chosenWordDialogueChanged.emit(chosenWordDialogue)
	compareWords()

func handle_Encyclopedia_url_tag_clicked(clue: String) -> void:
	print(clue)
	var n = clue.split(",")
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
		if !Dialogic.VAR.Tutorial.tutorialCompleted:
			if !Dialogic.VAR.Tutorial.questionClicked and Dialogic.VAR.Tutorial.bookClicked and chosenWordDictionary[0] != "monsterSelect":
				Dialogic.VAR.set_variable("Tutorial.questionClicked", true);
				Dialogic.start_timeline("Supervisor_01", "questionClicked");
				return
	
	# exception for clicking easteregg clue
	if chosenWordDialogue == "egg":
		chosenWordDictionary[0] = chosenWordDialogue
		chosenMonster = "_Basic"
		Dialogic.VAR.timer += 1
	
	# confirm choice of which monster it is
	if chosenMonster == "_MonsterSelect" && monsterSelect:
		if Dialogic.VAR.Tutorial.tutorialCompleted:
			Dialogic.start_timeline(dialog, chosenWordDictionary[0])
		else:
			if Dialogic.VAR.Tutorial.questionClicked and Dialogic.VAR.Tutorial.keywordClicked and !Dialogic.VAR.Tutorial.monsterSelectClicked:
				Dialogic.VAR.set_variable("Tutorial.monsterSelectClicked", true);
				Dialogic.start_timeline("Supervisor_01", "monsterSelectClicked");
	
	# entering Monster Selection mode
	if chosenWordDictionary.has("monsterSelect"):
		monsterSelect = !monsterSelect
		Dialogic.VAR._Basic.monsterSelect = monsterSelect
		flushClues()

	# compare clicked clues and set according variable	
	if chosenWordDictionary.has(chosenWordDialogue):
		if !Dialogic.VAR.Tutorial.tutorialCompleted:
			if Dialogic.VAR.Tutorial.questionClicked and !Dialogic.VAR.Tutorial.keywordClicked :
				Dialogic.VAR.set_variable("Tutorial.keywordClicked", true);
				Dialogic.start_timeline("Supervisor_01", "keywordClicked");
				return
		var v = chosenMonster + "." + chosenWordDialogue
		Dialogic.VAR.set_variable(v, true)
		Dialogic.VAR._MonsterSelect.set(chosenMonster, true)
		flushClues()
		
	if !chosenWordDictionary.has(chosenWordDialogue) && chosenWordDialogue != "":
		if Dialogic.VAR.Tutorial.tutorialCompleted:
			# Create a list of possible dialogues
			var wrong_connection_responses = [
				"*That doesn’t seem right. I should double-check those connections.*",
				"*Hmm, I don’t think I got that right. Maybe I missed something.*",
				"*Nope, that doesn’t fit. I need to try another option.*",
				"*Those don’t seem to match up. I’ll need to rethink this.*",
				"*That doesn’t look correct. Let me review the clues again.*",
				"*I’m sure I’ve made a wrong connection here. Time to go back to the notes.*",
				"*This doesn’t add up. I must’ve missed a key detail.*",
				"*That’s not right. Maybe the compendium has something I overlooked.*",
				"*I’ve made a mistake here. I need to reassess the situation.*",
				"*That connection doesn’t work. I should focus more on the anomaly’s traits.*"
			]
			# Pick a random dialogue
			var random_dialogue = wrong_connection_responses[randi() % wrong_connection_responses.size()]
			Dialogic.VAR.set_variable("wrongConnectionString", random_dialogue)
			Dialogic.VAR.set_variable("wrongConnection", true)
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

