extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var gradient = preload("res://rainbowBlockGradiant.tres");
var point;
var maxPoints;
var up = true;
# Called when the node enters the scene tree for the first time.
func _ready():
	point = 0;
	maxPoints = gradient.get_point_count()-1;

func update_points(points, fruitsLevel):
	$LevelProgress.value = fruitsLevel;
	$PointsProgress.value = points;
	
func level_up():
	$LevelProgress/CPUParticles2D.emitting =true;
	
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
func _process(delta):
	pass

func combo_made(type):
	match type:
		0:
			$BgButton/CPUParticles2D.emtting = true;
		1:
			$BgButton2/CPUParticles2D.emitting = true;


		

func _on_Timer_timeout():
	if (point >= maxPoints):
		up = false;
		point = maxPoints-1;
	if (point <= 0):
		up = true;
		point =0;
	if (up):
		point += 1;
	else:
		point -= 1;
	$LevelProgress.tint_over = gradient.get_color(point);
	$PointsProgress.tint_over = gradient.get_color(point);
	$BgButton.self_modulate = gradient.get_color(point);
	$BgButton2.self_modulate = gradient.get_color(point);
