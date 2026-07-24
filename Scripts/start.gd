extends Control

# Simple start screen, contains a simple paragraph explaining the story of the game

# var game_scene = preload("res://Scenes/main.tscn")
var clickable = true
var select = -1
var story_or_credits
var in_sub_menu = false

var line_count = 0
	

#Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fade_in = create_tween()
	fade_in.tween_property($Music, "volume_db", -10, 12).set_trans(Tween.TRANS_LINEAR)
	$story_text.hide()
	$VBoxContainer2/BackToMenu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("move_forward"):
		if select == -1:
			select = 1
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
			mouse_filter = Control.MOUSE_FILTER_IGNORE
		elif select > 1:
			select -= 1 
			set_controller_sprites(select)
			pass
	if Input.is_action_just_pressed("scroll_down"):
		if select == -1:
			select = 1
			set_controller_sprites(select)
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
			mouse_filter = Control.MOUSE_FILTER_IGNORE
		elif select >= 1 && select < 4:
			select += 1 
			set_controller_sprites(select)
			pass
	if Input.is_action_just_pressed("interact"):
		match select:
			0:
				_on_back_to_menu_pressed()
				if story_or_credits:
					select = 2
				else: 
					select = 3
				set_controller_sprites(select)
			1:
				_on_start_pressed()
			2:
				_on_story_pressed()
				select = 0
				set_controller_sprites(select)
				story_or_credits = true
			3:
				_on_credits_pressed()
				select = 0
				set_controller_sprites(select)
				story_or_credits = false
			4:
				_on_quit_pressed()
	
	var line_max = $story_text.get_line_count()
	
	if Input.is_action_pressed("move_forward") && in_sub_menu == true:
		$story_text.scroll_to_line(line_count)
		if line_count > 0:
			line_count -= 1
		pass
	if Input.is_action_pressed("scroll_down") && in_sub_menu == true:
		$story_text.scroll_to_line(line_count)
		if line_count < line_max:
			line_count += 1
		pass
	
	var mouse_mov = Input.get_last_mouse_velocity().length()
	if mouse_mov > 0:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		select = -1
		reset_sprites()

func _on_start_pressed() -> void:
	if clickable == true:
		get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_pressed() -> void:
	if clickable == true:
		get_tree().quit()

func _on_story_pressed() -> void:
	line_count = 0
	if clickable == true:
		$VBoxContainer.z_index = -3
		$VBoxContainer/Start.hide()
		$VBoxContainer/Story.hide()
		$VBoxContainer/Credits.hide()
		$VBoxContainer/Quit.hide()
		$story_text.show()
		$VBoxContainer2/BackToMenu.show()
		clickable = false
		in_sub_menu = true

func _on_back_to_menu_pressed() -> void: # Only pressable while on the story screen
	if clickable == false:
		$VBoxContainer.z_index = 0
		$VBoxContainer/Start.show()
		$VBoxContainer/Story.show()
		$VBoxContainer/Credits.show()
		$VBoxContainer/Quit.show()
		$story_text.hide()
		$VBoxContainer2/BackToMenu.hide()
		$story_text.text = "Kostromvik Union, 198X

After decades, a long abandoned nuclear reactor in a secluded region of the city of Krivichesk has mysteriously shown signs of activity. City records show no entry in or out of the region, or nothing else that would explain it, fueling decades-long whispers of strange happenings in the area. In a matter of three days, activity has grown exponentially and all signs indicate the unmanned reactor is rapidly approaching a meltdown. 

You have been tasked with going into the reactor and pushing the implosion back for long enough to conduct a safe evacuation. 
"
		in_sub_menu = false
		clickable = true

func _on_credits_pressed() -> void:
	if clickable == true:
		$story_text.text = "Game by Angel Zayas

Thanks to my beautiful girlfiend for helping me playtest this game and pushing me to make it in the first place.

[left]Contains modified textures from 3djungle.net.

All music and sound effects from pixabay.com

\"190501 - Dark / Industrial / Ambient / Mechanical / Electronica\" by WELC0MEИ0
https://pixabay.com/music/electronic-190501-dark-industrial-ambient-mechanical-electronica-155502/

\"220626 - Glitch / Dark / Industrial / IDM / Electronica / SF\" by WELC0MEИ0
https://pixabay.com/music/upbeat-220626-glitch-dark-industrial-idm-electronica-sf-155641/[/left]"
		_on_story_pressed()

func reset_sprites():
	$VBoxContainer/Start.texture_normal = load("res://Button Icons/Start.png")
	$VBoxContainer/Story.texture_normal = load("res://Button Icons/Story.png")
	$VBoxContainer/Credits.texture_normal = load("res://Button Icons/credits.png")
	$VBoxContainer/Quit.texture_normal = load("res://Button Icons/quit.png")
	$VBoxContainer2/BackToMenu.texture_normal = load("res://Button Icons/BackToMenu.png")
	
	$VBoxContainer/Start.texture_hover = load("res://Button Icons/Start_hover.png")
	$VBoxContainer/Story.texture_hover = load("res://Button Icons/Story_hover.png")
	$VBoxContainer/Credits.texture_hover = load("res://Button Icons/credits_hover.png")
	$VBoxContainer/Quit.texture_hover = load("res://Button Icons/quit_hover.png")
	$VBoxContainer2/BackToMenu.texture_hover = load("res://Button Icons/BackToMenu_hover.png")
	
func set_controller_sprites(button):
	match button:
		0:
			$VBoxContainer2/BackToMenu.texture_normal = load("res://Button Icons/BackToMenu_hover.png")
			$VBoxContainer2/BackToMenu.texture_hover = load("res://Button Icons/BackToMenu_hover.png")
		1:
			$VBoxContainer/Start.texture_normal = load("res://Button Icons/Start_hover.png")
			$VBoxContainer/Start.texture_hover = load("res://Button Icons/Start_hover.png")
			
			$VBoxContainer/Story.texture_normal = load("res://Button Icons/Story.png")
			$VBoxContainer/Story.texture_hover = load("res://Button Icons/Story.png")
			
			$VBoxContainer/Credits.texture_normal = load("res://Button Icons/credits.png")
			$VBoxContainer/Credits.texture_hover = load("res://Button Icons/credits.png")
			
			$VBoxContainer/Quit.texture_normal = load("res://Button Icons/quit.png")
			$VBoxContainer/Quit.texture_hover = load("res://Button Icons/quit.png")
		2:
			$VBoxContainer/Start.texture_normal = load("res://Button Icons/Start.png")
			$VBoxContainer/Start.texture_hover = load("res://Button Icons/Start.png")
			
			$VBoxContainer/Story.texture_normal = load("res://Button Icons/Story_hover.png")
			$VBoxContainer/Story.texture_hover = load("res://Button Icons/Story_hover.png")
			
			$VBoxContainer/Credits.texture_normal = load("res://Button Icons/credits.png")
			$VBoxContainer/Credits.texture_hover = load("res://Button Icons/credits.png")
			
			$VBoxContainer/Quit.texture_normal = load("res://Button Icons/quit.png")
			$VBoxContainer/Quit.texture_hover = load("res://Button Icons/quit.png")
		3:
			$VBoxContainer/Start.texture_normal = load("res://Button Icons/Start.png")
			$VBoxContainer/Start.texture_hover = load("res://Button Icons/Start.png")
			
			$VBoxContainer/Story.texture_normal = load("res://Button Icons/Story.png")
			$VBoxContainer/Story.texture_hover = load("res://Button Icons/Story.png")
			
			$VBoxContainer/Credits.texture_normal = load("res://Button Icons/credits_hover.png")
			$VBoxContainer/Credits.texture_hover = load("res://Button Icons/credits_hover.png")
			
			$VBoxContainer/Quit.texture_normal = load("res://Button Icons/quit.png")
			$VBoxContainer/Quit.texture_hover = load("res://Button Icons/quit.png")
		4: 
			$VBoxContainer/Start.texture_normal = load("res://Button Icons/Start.png")
			$VBoxContainer/Start.texture_hover = load("res://Button Icons/Start.png")
			
			$VBoxContainer/Story.texture_normal = load("res://Button Icons/Story.png")
			$VBoxContainer/Story.texture_hover = load("res://Button Icons/Story.png")
			
			$VBoxContainer/Credits.texture_normal = load("res://Button Icons/credits.png")
			$VBoxContainer/Credits.texture_hover = load("res://Button Icons/credits.png")
			
			$VBoxContainer/Quit.texture_normal = load("res://Button Icons/quit_hover.png")
			$VBoxContainer/Quit.texture_hover = load("res://Button Icons/quit_hover.png")
	pass
	
