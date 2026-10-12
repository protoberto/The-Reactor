# Keeps track of useful player data
extends Node

var cause_of_death = null # Player's cause of death, null before death
var beat_game = false # Keeps track of whether the player has beat the game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventHandler.game_over.connect(update_cause_of_death)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
# Updates the player's cause of death and passes it onto the death screen
func update_cause_of_death(cod):
	cause_of_death = cod
	
func victory(): # Confirms the player has beat the game at least once
	beat_game = true
