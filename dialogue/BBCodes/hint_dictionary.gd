#@tool
extends RichTextEffect
class_name HintDictionaryRichTextEffect


# Syntax: [option][/option]
var firstWordChosen = false
var bbcode = "hint"
var setActive: bool=false
#var chosenMonster
#var chosenWordDictionary

func _init() -> void:
	ClickTextEventHandler.chosenWordDictionaryChanged.connect(_on_chosenWordDictionaryChanged)

func _process_custom_fx(char_fx):
	var name = char_fx.env.get("name")
	if !name.is_empty() and firstWordChosen:
		var name_chosenMonster = name[0]
		var name_chosenWordDictionary = name[1]
		setActive = name_chosenMonster == ClickTextEventHandler.chosenMonster and name_chosenWordDictionary == ClickTextEventHandler.chosenWordDictionary[0]
	else:
		setActive = false
		
	if setActive:
		char_fx.color = Color.WHITE
	else:
		char_fx.color = Color.BLACK
	return true

func _on_chosenWordDictionaryChanged(monster, dictionary):
	firstWordChosen = true
	#var chosenMonster = monster
	#var chosenWordDictionary = dictionary
