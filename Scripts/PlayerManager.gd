extends Node

signal received_player_data

var cfg_file_path: String = "user://player.cfg"
var cfg_file: ConfigFile = null

var restored = false


func fetch_player_data():
	# Check if we have a uuid stored.
	# If yes, send it to the server to retrieve player info.

	if not OS.is_userfs_persistent():
		print("Your file system is not persistent. Game data will not be stored...")

	var data = {}
	cfg_file = ConfigFile.new()
	var err = cfg_file.load(cfg_file_path)
	if err == OK:
		# Load in existing player id
		var uuid = cfg_file.get_value("player", "uuid", null)
		if uuid:
			data["uuid"] = uuid

	RequestManager.make_request("player", self, "_on_player_data", data)


func _on_player_data(response: PoolByteArray) -> void:
	var parsed = JSON.parse(response.get_string_from_utf8())
	if parsed.error:
		cfg_file.set_value("player", "name", "error :(")
		printerr("Something went wrong.")

	if parsed.result.code == OK:
		cfg_file.set_value("player", "uuid", parsed.result.uuid)
		cfg_file.set_value("player", "name", parsed.result.name)
		cfg_file.set_value("player", "id", int(parsed.result.id))
		cfg_file.save(cfg_file_path)

		restored = true
		emit_signal("received_player_data")


func get_name() -> String:
	return (
		"%s#%d"
		% [cfg_file.get_value("player", "name", null), cfg_file.get_value("player", "id", 0)]
	)


func get_name_dict(dict: Dictionary) -> String:
	return "%s#%d" % [dict.name, dict.id]


func get_uuid() -> String:
	return cfg_file.get_value("player", "uuid", "")
