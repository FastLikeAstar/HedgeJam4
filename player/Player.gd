extends KinematicBody2D



enum movement_state{
	idle,
	running
}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera_position



var maxSpeed = 850;
var baseSpeed = 800;  # speed in pixels/sec
var velocity = Vector2.ZERO;
var maxRunBonus = 100;
var bonusSpeed = 0;
var runBonus = 0;
var actualSpeed = 0;
var currentSpeedLevel = 0;
var attemptedSpeed = 0;
var runDecrease = 1;
var fruitLevel = 0;
var fruitPointBreakPoint = 20;
var fruitPoints = 0;
var lowestSpeed = baseSpeed - 100;

signal level_up;
signal current_points;
signal game_win;


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("player");

func add_camera(camera_path):
	$RemoteTransform2D.remote_path = camera_path;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
		$AnimatedSprite.set_frame(0);
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		$AnimatedSprite.set_frame(1);
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_just_pressed("run_faster"):
		runBonus += 20;
		runBonus = clamp(runBonus, 0, maxRunBonus);
		
		
	# Make sure diagonal movement isn't faster
	attemptedSpeed = baseSpeed + bonusSpeed + runBonus;
	actualSpeed = clamp(attemptedSpeed, 0, maxSpeed+bonusSpeed);
	velocity = velocity.normalized() * actualSpeed;

func _physics_process(_delta):
	get_input();
	velocity = move_and_slide(velocity);
	if (runBonus > 0 && Input.is_action_pressed("run_faster")):
		runBonus -= runDecrease;

func change_speed(speedDelta):
	if (bonusSpeed + baseSpeed) < lowestSpeed:
		if speedDelta < 0:
			bonusSpeed +=(speedDelta * 4);
	else:
		bonusSpeed += speedDelta;

func change_points(deltaPoints):
	fruitPoints += deltaPoints;
	if fruitPoints > fruitPointBreakPoint:
		fruitLevel += 1;
		if fruitLevel > 5:
			emit_signal("game_win");
		else:
			emit_signal("level_up", fruitLevel);
	emit_signal("current_points", fruitPoints, fruitLevel);
