@tool
extends RichTextEffect
class_name HintDictionaryRichTextEffect


# Syntax: [option][/option]
var bbcode = "hint"
var setActive: bool=false
var chosenMonster
var chosenWordDictionary

#func _init() -> void:
	#ClickTextEventHandler.chosenWordDictionaryChanged.connect(_on_chosenWordDictionaryChanged)

func _process_custom_fx(char_fx):
	var name = char_fx.env.get("name")
	if !name.is_empty():
		var name_chosenMonster = name[0]
		name.remove_at(0)
		var name_chosenWordDictionary = name
		setActive = name_chosenMonster == chosenMonster and name_chosenWordDictionary == chosenWordDictionary
	else:
		setActive = false
		
	if setActive:
		char_fx.color = Color.CYAN
	else:
		char_fx.color = Color.WHITE
	return true

#func _on_chosenWordDictionaryChanged(monster, dictionary):
	#var n = name.split(",")
	#var chosenMonster = n[0]
	#n.remove_at(0)
	#var chosenWordDictionary = n
