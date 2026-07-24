extends Control

# Simple game over screen, has the option for a player to restart 

# var game_scene = preload("res://Scenes/main.tscn")
var cause_of_death = null
var select = -1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cause_of_death = Data.cause_of_death
	match cause_of_death:
		0:
			$DeathScreen.texture = load("res://Screens/big guy death.png")
		1:
			$DeathScreen.texutre = load("res://Screens/gameover.png")
		2: 
			$DeathScreen.texture = load("res://Screens/terminator-2-judgment-day.jpg")
			$DeathScreen.scale = Vector2(2, 2)
	match (randi_range(0, 6)):
		0:
			$Tip.text = "Keep an ear out for footsteps, you're never as safe as you think."
		1:
			$Tip.text = "You can turn away from the terminals if things get risky, don't get cocky."
		2:
			$Tip.text = "The small one doesn't like the terminals, the lights hurt its eyes."
		3:
			$Tip.text = "The small one doesn't care about you, you're just in its way."
		4:
			$Tip.text = "You don't need to completely fix the terminals, but doing so might make things easier."
		5: 
			$Tip.text = "Always look before you move, you never know what lies in the dark."
		6: 
			$Tip.text = "Remember what you came here to do, don't let those terminals break."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("move_forward"):
		controller_input()
		pass
	if Input.is_action_just_pressed("scroll_down"):
		controller_input()
		pass
		
	var mouse_mov = Input.get_last_mouse_velocity().length()
	if mouse_mov > 0:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		select = -1
		$CenterContainer/VBoxContainer/Quit.texture_normal = load("res://Button Icons/quit.png")
		$CenterContainer/VBoxContainer/Quit.texture_hover = load("res://Button Icons/quit_hover.png")
		$CenterContainer/VBoxContainer/Restart.texture_normal = load("res://Button Icons/TryAgain.png")
		$CenterContainer/VBoxContainer/Restart.texture_hover = load("res://Button Icons/TryAgain_hover.png")

func controller_input():
	if select == -1:
		select = 0
		set_sprites(select)
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		mouse_filter = Control.MOUSE_FILTER_IGNORE
	elif select == 0:
		select = 1 
		set_sprites(select)
	elif select == 1:
		select = 0 
		set_sprites(select)
	pass
func set_sprites(choice):
	if choice == 0:
		$CenterContainer/VBoxContainer/Quit.texture_normal = load("res://Button Icons/quit.png")
		$CenterContainer/VBoxContainer/Quit.texture_hover = load("res://Button Icons/quit.png")
		$CenterContainer/VBoxContainer/Restart.texture_normal = load("res://Button Icons/TryAgain_hover.png")
		$CenterContainer/VBoxContainer/Restart.texture_hover = load("res://Button Icons/TryAgain_hover.png")
	else:
		$CenterContainer/VBoxContainer/Quit.texture_normal = load("res://Button Icons/quit_hover.png")
		$CenterContainer/VBoxContainer/Quit.texture_hover = load("res://Button Icons/quit_hover.png")
		$CenterContainer/VBoxContainer/Restart.texture_normal = load("res://Button Icons/TryAgain.png")
		$CenterContainer/VBoxContainer/Restart.texture_hover = load("res://Button Icons/TryAgain.png")

func _on_restart_pressed() -> void: # Restarts the game
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit() # Closes the game
