@tool
extends RichTextEffect
class_name OptionRichTextEffect


# Syntax: [option][/option]
var bbcode = "option"
var setActive: bool=false

func _process_custom_fx(char_fx):
	var name = char_fx.env.get("name", "dizzy")
	var isDialogueElseDictionary = char_fx.env.get("isDialogue", true)
	if isDialogueElseDictionary:
		var _temp = ClickTextEventHandler.chosenWordDialogue
		var _equal = ClickTextEventHandler.chosenWordDialogue == name
		setActive = ClickTextEventHandler.chosenWordDialogue == name
	else:
		setActive = ClickTextEventHandler.chosenWordDictionary == name
	if setActive:
		char_fx.color = Color.CYAN
	else:
		char_fx.color = Color.WHITE
	return true
