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
		setActive = ClickTextEventHandler.get("chosenWordDialogue") == name
	else:
		setActive = ClickTextEventHandler.get("chosenWordDictionary") == name
	if true:
		char_fx.color = Color.CYAN
	else:
		char_fx.color = Color.WHITE
	return true
