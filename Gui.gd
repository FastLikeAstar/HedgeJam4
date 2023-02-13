extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_points(points, fruitsLevel):
	$LevelProgress.value = fruitsLevel;
	$PointsProgress.value = points;
	
func new_level(newLevel):
	pass
	
func update_count(timeLeft: float):
	var minutes := timeLeft / 60;
	var seconds := fmod(timeLeft, 60);
	var text = "%02d:%02d" % [minutes, seconds];
	$Time.set_text(text);

func update_time(currentTime : float):
	var minutes := currentTime / 60;
	var seconds := fmod(currentTime, 60);
	var text = "%02d:%02d" % [minutes, seconds];
	$Time.set_text(text);
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
