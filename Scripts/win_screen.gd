extends Control

# Simple win screen

var on_controller = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fade_in = create_tween()
	fade_in.tween_property($Music, "volume_db", -5, 15).set_trans(Tween.TRANS_LINEAR)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("move_forward"):
		switch_to_controller()
	if Input.is_action_just_pressed("scroll_down"):
		switch_to_controller()
	if Input.is_action_just_pressed("interact") && on_controller:
		_on_button_pressed()
	var mouse_mov = Input.get_last_mouse_velocity().length()
	if mouse_mov > 0:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		on_controller = false
		$Button.texture_normal = load("res://Button Icons/BackToMenu.png")

func switch_to_controller():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	on_controller = true
	$Button.texture_normal = load("res://Button Icons/BackToMenu_hover.png")
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start.tscn")
