class_name SubmitButton
extends Button


func _pressed():
	disabled = true

	# prepare the data:
	var data = GlobalAccess.node_container.get_visited_ids_array()

	#endpoint : String, caller : Object, callback : String, parameters : Dictionary = {}
	RequestManager.make_request(
		"check", self, "_on_server_reply", {"uuid": PlayerManager.get_uuid(), "recipe": data}, true
	)


func _on_server_reply(body: PoolByteArray):
	disabled = false
	print(body.get_string_from_utf8())

	var res = JSON.parse(body.get_string_from_utf8())
	if res.error != OK:
		print("ERROR PARSING MESSAGE")

	GlobalAccess.emit_signal("received_results", res.result)
