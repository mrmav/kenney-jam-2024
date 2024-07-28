class_name ScoreTable
extends Control

export(PackedScene) var table_row = null


func _ready():
	# fetch results
	RequestManager.make_request("players", self, "_on_players_info")


func _on_players_info(response: PoolByteArray):
	var parse = JSON.parse(response.get_string_from_utf8())
	if parse.error != OK:
		printerr("Oooops, error on players info response.")
		return

	var data: Array = parse.result
	var pos: int = 0
	for item in data:
		# the returned data is already sorted
		var i = table_row.instance()
		i.id = int(item.id)
		i.pname = item.name
		i.score = float(item.best_score)
		i.pos = pos

		add_child(i)

		pos += 1
