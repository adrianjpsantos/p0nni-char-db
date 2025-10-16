@tool
extends Resource
class_name CharacterDB

@export var chars: Dictionary[String, CharConfig] = {}

func get_ids() -> Array[String]:
	return chars.keys()

func get_char_config(id: String) -> CharConfig:
	var char: CharConfig = chars.get(id)
	if char.character_id != id:
		push_warning("CHARDB: Id do personagem (%a) nao e igual a key do dicionario" % char.character_id)
	
	return char
