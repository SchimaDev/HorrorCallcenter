@tool
extends RichTextEffect
class_name HintDictionaryRichTextEffect


# Syntax: [option][/option]
var bbcode = "hint"
var setActive: bool=false
var name

func _init() -> void:
	ClickTextEventHandler.chosenWordDictionaryChanged.connect(_on_chosenWordDictionaryChanged)

func _process_custom_fx(char_fx):
	name = char_fx.env.get("name")
	if setActive:
		char_fx.color = Color.CYAN
	else:
		char_fx.color = Color.WHITE
	return true

func _on_chosenWordDictionaryChanged(monster, dictionary):
	var chosenWordDictionary = dictionary
	var chosenMonster = monster
	setActive = chosenMonster == monster and chosenWordDictionary == dictionary
