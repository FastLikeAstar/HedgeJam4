extends KinematicBody2D



enum movement_state{
	idle,
	running
}
enum last_direction{
	up,
	down,
	right,
	left
}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera_position



#var maxSpeed = 550;
var baseSpeed = 300;  # speed in pixels/sec
var velocity = Vector2.ZERO;
var maxRunBonus = 120;
var bonusSpeed = 0;
var runBonus = 0;
var actualSpeed = 0;
var currentSpeedLevel = 0;
var attemptedSpeed = 0;
var runDecrease = 35;
var fruitLevel = 0;
var fruitPointBreakPoint = 50;
var fruitPoints = 0;
var lowestSpeed = 200;
var lastPressedDirection;

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
	lastPressedDirection = "down";

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
		velocity.x += 1;
		lastPressedDirection = "right";
		
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		lastPressedDirection = "left";
		
	if Input.is_action_pressed('down'):
		velocity.y += 1;
		lastPressedDirection = "down";
		
	if Input.is_action_pressed('up'):
		velocity.y -= 1;
		lastPressedDirection = "up";
		
		
	if Input.is_action_just_pressed("run_faster"):
		AudioManager.player_speedup();
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
	actualSpeed = clamp(attemptedSpeed, lowestSpeed, baseSpeed+bonusSpeed);
	velocity = velocity.normalized() * actualSpeed;
	if (velocity.x == 0 && velocity.y == 0):
		match lastPressedDirection:
			"up":
				$AnimatedSprite.animation =  "idle_down";
			"down":
				$AnimatedSprite.animation =  "idle_down";
			"left":
				$AnimatedSprite.animation =  "idle_left";
			"right":
				$AnimatedSprite.animation =  "idle_right";
	elif (abs(velocity.y) >= abs(velocity.x)):
		if (velocity.y > 0):
			$AnimatedSprite.animation =  "moving_down";
		else:
			$AnimatedSprite.animation =  "moving_down";
	else:
		if (velocity.x > 0):
			$AnimatedSprite.animation =  "moving_right";
		else:
			$AnimatedSprite.animation =  "idle_left";
			

func _physics_process(_delta):
	get_input();
	velocity = move_and_slide(velocity);
	if (velocity.y != 0 || velocity.x !=0):
		AudioManager.player_walking(fruitLevel);
	else:
		AudioManager.player_idle();


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
		if (fruitLevel >= 5):
			AudioManager.player_levelup()
			emit_signal("game_win");
			end_session();
			print("Game Won");
		else:
			emit_signal("level_up", fruitLevel);
			if (fruitLevel == 1):
				AudioManager.player_levelup()
				$AnimatedSprite.scale = Vector2(1.1, 1.1);
				print("Level 1");
			elif (fruitLevel == 2):
				AudioManager.player_levelup()
				$AnimatedSprite.scale = Vector2(1.2, 1.2);
				AudioManager.player_idle();
				print("Level 2");
			elif (fruitLevel == 3):
				AudioManager.player_levelup()
				$AnimatedSprite.scale = Vector2(1.4, 1.4);
				print("Level 3");
			elif (fruitLevel == 4):
				AudioManager.player_idle();
				print("Level 4");
				AudioManager.player_levelup()
				$AnimatedSprite.scale = Vector2(1.8, 1.8);
	emit_signal("current_points", fruitPoints, fruitLevel);

func end_session():
	$DeathParticles.emitting = true;
	$AnimatedSprite.modulate = Color(0, 0, 0, 0);
	
	
func speedup_emit(speedAmount):
	$SpeedUpParticles.emitting = true;
	$SpeedUpParticles.amount = speedAmount *2;

func _on_DashTimer_timeout():
	runBonus -= runDecrease;
	runBonus = clamp(runBonus, 0, maxRunBonus);


func _on_DashFeedback_timeout():
	$CPUParticles2D.emitting = false;
	$BigDash.emitting = false;
