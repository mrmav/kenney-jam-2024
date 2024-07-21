extends Node

var domain = "http://localhost:3000"

func _ready():
	
	if not OS.is_debug_build():
		domain = "https://mrmav-jam.com"


func make_request(endpoint : String, caller : Object, callback : String, parameters : Dictionary = {}):
	var http = HTTPRequest.new()
	
	add_child(http)
	http.connect("request_completed", self, "_request_callback", [http, caller, callback])
	
	var url = get_url(endpoint, parameters)
	print("Requesting ", url)
	var error = http.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")


func get_url(endpoint : String, parameters : Dictionary) -> String:
	
	var result = "%s/%s?version=v1" % [domain, endpoint]
	
	for p in parameters:
		result += "&%s=%s" % [p, Marshalls.utf8_to_base64(str(parameters[p]))]
	
	return result


func _request_callback(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray, http, caller, callback):
	
	if result != HTTPRequest.RESULT_SUCCESS:
		prints("Server error.", result)
		
	
	if response_code != HTTPClient.RESPONSE_OK:
		prints("Bad response from server", response_code)
	
	caller.callv(callback, [body])
	http.queue_free()