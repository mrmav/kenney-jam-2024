extends Node

func _ready():
	
	# Check if we have a uuid stored.
	# If yes, send it to the server to retrieve player info.
	
	if not OS.is_userfs_persistent():
		print("Your file system is not persistent. Game data will not be stored...")		
	
	var id = ""
	#var fs = File.open("usr://data.json")
	
	# endpoint : String, caller : Object, callback : String, parameters : Dictionary = {}, encode = false
	RequestManager.make_request("/player", self, "_on_player_data", { uuid = id });
