extends Control

export var hover_button_path: NodePath
export var submitText_path: NodePath
export var clouds_path: NodePath
export var background_animation_path: NodePath
export var char_animation_player_path: NodePath
export var dismiss_btn_nodepath: NodePath
export var beard_nodepath: NodePath

export(float) var needed_hover_time_sec = 1.0

var hover_button: Button
var submit_text: Control
var cloud: Control
var background_animation: AnimationPlayer
var char_animation_player: AnimationPlayer
var dismiss_btn: Button
var beard

var start_offset = Vector2(0, 100)
var start_offset_submit = Vector2(0, -150)

var submit_open = false
var _target_over_time: float = -1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	hover_button = get_node(hover_button_path) as Button
	submit_text = get_node(submitText_path) as Control
	cloud = get_node(clouds_path) as Control
	#background_animation = get_node(background_animation_path) as AnimationPlayer
	char_animation_player = get_node(char_animation_player_path) as AnimationPlayer
	dismiss_btn = get_node(dismiss_btn_nodepath)
	beard = get_node(beard_nodepath)

	hover_button.connect("mouse_entered", self, "_on_HoverButton_mouse_entered")
	hover_button.connect("mouse_exited", self, "_on_HoverButton_mouse_leave")
	hover_button.connect("pressed", self, "_on_Button_pressed")

	dismiss_btn.connect("pressed", self, "_dismiss")


func _process(_delta):
	if submit_open or _target_over_time < 0.0:
		return

	if Time.get_ticks_msec() >= _target_over_time:
		_open()


func _on_HoverButton_mouse_entered() -> void:
	if submit_open:
		return

	beard.animate()

	_target_over_time = Time.get_ticks_msec() + needed_hover_time_sec * 1000.0


func _on_HoverButton_mouse_leave() -> void:
	if submit_open:
		return

	_target_over_time = -1.0


func _on_Button_pressed() -> void:
	_dismiss()


func _open():
	print("Hello ")
	submit_open = true
	#background_animation.play("A_backgroundSwitch_off")
	char_animation_player.play("reveal")


func _dismiss():
	print("Bye ")
	_reset()
	#background_animation.play("A_backgroundSwitch_on")
	char_animation_player.play("reveal", -1, -1, true)


func _reset():
	submit_open = false
	_target_over_time = -1.0


func toggle_thinking_clouds():
	cloud.visible = !cloud.visible
	cloud.get_node("AnimationPlayer").seek(0.0, true)
