extends Control

var feed_words = ["discovered", "found", "invented", "transmutated", "did some"]

func _ready():
	
	randomize()

	# pick random pattern
	var files = []
	var dir = Directory.new()
	if dir.open("res://Graphics/Textures/Others/Patterns") == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.get_extension() == "png":
				files.append("res://Graphics/Textures/Others/Patterns/" + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
		
	$Viewport/CanvasLayer2/TextureRect.texture = load(files.pick_random())
	
	
	PlayerManager.fetch_player_data()
	RequestManager.make_request("feed", self, "_on_feed_received")
	

func _on_feed_received(response: PoolByteArray):
	
	var parse = JSON.parse(response.get_string_from_utf8())
	if parse.error != OK:
		printerr("Oooops, error on feed info response.")
		return

	var data: Array = parse.result
	var feed_container = $Feed/ScrollContainer/VBoxContainer
	var label = preload("res://FeedLabel.tscn")
	for item in data:
		var i = label.instance()
		var time : Dictionary = Time.get_datetime_dict_from_unix_time(item.timestamp / 1000.0)
		var display_string : String = Time.get_datetime_string_from_datetime_dict(time, true)
		i.text = "%s: %s %s %s%s" % \
			[
				display_string,
				item.player_name,
				feed_words.pick_random(),
				item.recipe_name.to_lower().capitalize(),
				[".", "!", "..."].pick_random()
			]
		feed_container.add_child(i)
		
