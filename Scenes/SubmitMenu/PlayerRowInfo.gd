class_name PlayerInfo
extends HBoxContainer

var pos: int = 0
var id: int = 0
var pname: String = ""
var score: float = 0.0

var _suffix = ["st", "nd", "rd", "th"]


func _ready():
	$name.text = PlayerManager.get_name_dict({"name": pname, "id": id})
	$score.text = "%1.2f" % score

	$position.text = "%d%s" % [pos + 1, get_pos_suffix(pos)]


func get_pos_suffix(i) -> String:
	var _last_i = _suffix.size() - 1
	var index = i % 10
	index = _last_i if i >= 10 and i < 20 else index
	return _suffix[index if index < _last_i else _last_i]
