class_name CharDBLoader

const CHARACTER_DB_PATH = "res://database/CharacterDB.tres"

func load_db_enum() -> String:
    var db: CharacterDB = load(CHARACTER_DB_PATH)
	var ids_list = []
	if is_instance_valid(db):
		ids_list = db.get_ids()
	
	# 2. Formata a lista para o Inspector
	# O Godot espera uma string de IDs e seus respectivos valores numéricos (opcionalmente)
	# Formato: "ID_CODE_1,ID_CODE_2,ID_CODE_3"
	# Como queremos que sejam strings, o formato é simples:
	var hint_string = ",".join(ids_list)
    return hint_string