@tool
extends RichTextEffect
class_name HintDialogueRichTextEffect


# Syntax: [option][/option]
var bbcode = "hint"
var setActive: bool=false
var name

#func _init() -> void:
	#ClickTextEventHandler.chosenWordDialogueChanged.connect(_on_chosenWordDictionaryChanged)

func _process_custom_fx(char_fx):
	name = char_fx.env.get("name")
	setActive = name == ClickTextEventHandler.chosenWordDialogue
	if setActive:
		char_fx.color = Color.CYAN
	else:
		char_fx.color = Color.WHITE
	return true

#func _on_chosenWordDictionaryChanged(word):
	#setActive = name == word
