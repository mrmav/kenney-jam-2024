extends Button
class_name SubmitButton

func _ready():
	pass
	

func _pressed():
	
	disabled = true
	
	#endpoint : String, caller : Object, callback : String, parameters : Dictionary = {}
	RequestManager.make_request("check", self, "_on_server_reply", {"recipe" : [10, 5, 7]})
	

func _on_server_reply(body : PoolByteArray):
	disabled = false
	print(body.get_string_from_utf8())
