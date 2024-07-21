extends Node

signal request_colors
signal colors_received

var initialized = false

var node_colors_array = []


func get_node_color(index : int):
	
	if index < 0 or index > node_colors_array.size():
		print("OUT OF BOUNDS COLOR NODE")
		return Color.black
	
	return node_colors_array[index]


func _ready():
	connect("request_colors", self, "_request_colors")


func _request_colors():	
	RequestManager.make_request("get_colors", self, "_on_received_colors", {"count": TreeNode.get_last_id() + 1})


func _on_received_colors(body):
	
	var res = JSON.parse(body.get_string_from_utf8())
	if res.error != OK:
		print("ERROR PARSING MESSAGE")
	
	for color in res.result:
		#print(color.to_lower().lstrip("#"))
		
		var alpha = color.substr(color.length() - 2, 2)
		var base = color.substr(1, 6)
		
		#node_colors_array.append(Color8(color.color[0], color.color[1], color.color[2], color.valpha))
		node_colors_array.append(Color(alpha + base))
	
	#print(node_colors_array[0])
	
	initialized = true
	emit_signal("colors_received")
