extends KinematicBody2D



enum movement_state{
	idle,
	running
}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera_position



#var maxSpeed = 550;
var baseSpeed = 300;  # speed in pixels/sec
var velocity = Vector2.ZERO;
var maxRunBonus = 100;
var bonusSpeed = 0;
var runBonus = 0;
var actualSpeed = 0;
var currentSpeedLevel = 0;
var attemptedSpeed = 0;
var runDecrease = 35;
var fruitLevel = 0;
var fruitPointBreakPoint = 20;
var fruitPoints = 0;
var lowestSpeed = 200;

signal level_up;
signal current_points;
signal game_win;


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("player");
	print("Game Started");
	$CPUParticles2D.emitting = false;
	$CPUParticles2D.local_coords = false;
	$BigDash.emitting = false;
	$BigDash.local_coords = false;

func add_camera(camera_path):
	$RemoteTransform2D.remote_path = camera_path;
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#var particleAmount = runBonus + 10;
	#print(str(particleAmount));
	#$CPUParticles2D.set_amount(particleAmount);

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
		$AnimatedSprite.animation =  "idle_right";

		
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		$AnimatedSprite.animation =  "idle_left";
		
	if Input.is_action_pressed('down'):
		velocity.y += 1
		$AnimatedSprite.animation =  "idle_down";
		
	if Input.is_action_pressed('up'):
		velocity.y -= 1
		
		
	if Input.is_action_just_pressed("run_faster"):
		$DashTimer.start(1);
		$DashFeedback.start(0.5);
		$DashFeedback.start(0.5);

		runBonus += 20;
		runBonus = clamp(runBonus, 0, maxRunBonus);
		if (runBonus >= maxRunBonus):
			$BigDash.emitting = true;
		else:
			$CPUParticles2D.emitting = true;
		
		
	# Make sure diagonal movement isn't faster
	attemptedSpeed = baseSpeed + bonusSpeed + runBonus;
	actualSpeed = clamp(attemptedSpeed, 0, baseSpeed+bonusSpeed);
	velocity = velocity.normalized() * actualSpeed;

func _physics_process(_delta):
	get_input();
	velocity = move_and_slide(velocity);


func change_speed(speedDelta):
	if (bonusSpeed + baseSpeed) < lowestSpeed:
		if speedDelta < 0:
			bonusSpeed +=(speedDelta * 4);
	else:
		bonusSpeed += speedDelta;

func change_points(deltaPoints):
	fruitPoints += deltaPoints;
	if (fruitPoints > fruitPointBreakPoint):
		fruitLevel += 1;
		fruitPoints -= fruitPointBreakPoint;
		if (fruitLevel > 5):
			emit_signal("game_win");
			print("Game Won");
		else:
			emit_signal("level_up", fruitLevel);
			if (fruitLevel == 1):
				$AnimatedSprite.scale = Vector2(1.1, 1.1);
				print("Level 1");
			elif (fruitLevel == 2):
				$AnimatedSprite.scale = Vector2(1.2, 1.2);
				print("Level 2");
			elif (fruitLevel == 3):
				$AnimatedSprite.scale = Vector2(1.4, 1.4);
				print("Level 3");
			elif (fruitLevel == 4):
				print("Level 4");
				$AnimatedSprite.scale = Vector2(1.8, 1.8);
	emit_signal("current_points", fruitPoints, fruitLevel);


func _on_DashTimer_timeout():
	runBonus -= runDecrease;
	runBonus = clamp(runBonus, 0, maxRunBonus);


func _on_DashFeedback_timeout():
	$CPUParticles2D.emitting = false;
	$BigDash.emitting = false;
