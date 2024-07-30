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
	var n = name.split(", ")
	var chosenMonster = n[0]
	n.remove_at(0)
	var chosenWordDictionary = n
	setActive = chosenMonster == monster and chosenWordDictionary == dictionary
