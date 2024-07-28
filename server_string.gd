extends Label

#var url = "http://localhost:3000"
var url = "https://mrmav-jam.com"
var post_endpoint = "/post-data"

var http_request : HTTPRequest = null

func _ready():
	
	if OS.has_feature("web"):
		queue_free()
	
	# Create an HTTP request node and connect its completion signal.
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")

	# Perform a GET request. The URL below returns JSON as of writing.
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	
func _input(event):	
	if event is InputEventKey:		
		if event.scancode == 32 and event.pressed and not event.echo:
	
			# Perform a POST request. The URL below returns JSON as of writing.
			# Note: Don't make simultaneous requests using a single HTTPRequest node.
			# The snippet below is provided for reference only.
			var body = to_json({"name": "Godette"})
			var error = http_request.request(url + post_endpoint, ["Content-Type: application/json"], true, HTTPClient.METHOD_POST, body)
			if error != OK:
				push_error("An error occurred in the HTTP request.")


# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	var response = body.get_string_from_utf8()

	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	text = response

