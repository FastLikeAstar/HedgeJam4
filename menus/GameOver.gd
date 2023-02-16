extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayAgain_button_down():
	get_tree().change_scene("res://level/World.tscn");


func _on_MainMenu_button_down():
	get_tree().change_scene("res://Menu.tscn");

func game_won(points, previous_highscore):
	previous_highscore = $VBoxContainer/HBoxContainer/PreviousHighscore.text + previous_highscore;
	previous_highscore = $VBoxContainer/HBoxContainer5/score.text + points;
