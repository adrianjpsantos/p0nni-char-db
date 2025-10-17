@tool
extends Object
class_name CharDBLoader

const CHARACTER_DB_SCRIPT_PATH = "res://addons/p0nni_char_db/scripts/character_db.gd"
const CHARACTER_DB_PATH = "res://database/CharacterDB.tres"

func load_db_enum() -> String:
	var db: CharacterDB = _ensure_db_exists()
	
	if not is_instance_valid(db):
		push_error("CharDBLoader: Não foi possível carregar ou criar o CharacterDB.")
		return ""
		
	var ids_list = db.get_ids()
	var hint_string = ",".join(ids_list)

	return "" if ids_list.is_empty() else hint_string


func _ensure_db_exists() -> CharacterDB:
	var db: CharacterDB = ResourceLoader.load(CHARACTER_DB_PATH)
	
	if is_instance_valid(db):
		return db
		
	
	var db_script: Script = ResourceLoader.load(CHARACTER_DB_SCRIPT_PATH)
	if not is_instance_valid(db_script) or not db_script is Script:
		push_error("CharDBLoader: Falha ao carregar o script do DB em: %s" % CHARACTER_DB_SCRIPT_PATH)
		return null

	var dir_path = CHARACTER_DB_PATH.get_base_dir()
	if not DirAccess.dir_exists_absolute(dir_path):
		var dir = DirAccess.open("res://")
		if dir:
			dir.make_dir_recursive(dir_path.trim_prefix("res://"))
		else:
			push_error("CharDBLoader: Falha ao abrir 'res://' para criar o diretório.")
			return null
	
	db = CharacterDB.new()
	
	db.set_script(db_script)
	
	var error = ResourceSaver.save(db, CHARACTER_DB_PATH)
	
	if error == OK:
		print("CharDBLoader: CharacterDB.tres criado automaticamente com script.")
		if Engine.is_editor_hint():
			EditorInterface.get_resource_filesystem().scan_changes()
		return db
	else:
		push_error("CharDBLoader: Erro ao salvar o CharacterDB.tres: %s" % error)
		return null
