extends KinematicBody2D

var velocity = Vector2(0, 0);
var coins = 0;

const DELTA_VELOCITY = 180;
const JUMP_FORCE = -950;
const GRAVITY = 35;

var ouch_sounds = [
	load("res://Assets/Sounds/ouch01.mp3"),
	load("res://Assets/Sounds/ouch02.mp3"), 
	load("res://Assets/Sounds/ouch04.mp3"), 
	load("res://Assets/Sounds/ouch05.mp3")
];

var jump_sounds = [
	load("res://Assets/Sounds/jump02.mp3"),
	load("res://Assets/Sounds/jump03.mp3"),
	load("res://Assets/Sounds/jump04.mp3"),
];

func _ready():
	for sound in ouch_sounds + jump_sounds:
		sound.set_loop(false);

func _physics_process(delta):
	
	if Input.is_action_pressed("right") and is_on_floor():
		velocity.x = DELTA_VELOCITY;
		$Sprite.play("walk");
		$Sprite.flip_h = false;
	elif Input.is_action_pressed("left") and is_on_floor():
		velocity.x = -DELTA_VELOCITY;
		$Sprite.play("walk");
		$Sprite.flip_h = true;
	else:
		if (is_on_floor()):
			$Sprite.play("idle");
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		var i = randi() % jump_sounds.size();
		print("Jump sound #", i);
		$PlayerSound.stream = jump_sounds[i];
		$PlayerSound.play();
		velocity.y = JUMP_FORCE;
		
	velocity.y += GRAVITY;

	velocity = move_and_slide(velocity, Vector2.UP)
	
	if (is_on_floor()):
		velocity.x = lerp(velocity.x, 0, 0.2);

func bounce():
	velocity.y = JUMP_FORCE / 2;

func ouch(var posx):
	set_modulate(Color(1, .3, .3, .25))
	velocity.y = JUMP_FORCE / 2;
	if (position.x < posx):
		velocity.x = -DELTA_VELOCITY;
	else:
		velocity.x = DELTA_VELOCITY;
	Input.action_release("left")
	Input.action_release("right")
	var i = randi() % ouch_sounds.size();
	$PlayerSound.stream = ouch_sounds[i]
	$PlayerSound.play()
	$Timer.start()

func _on_Timer_timeout():
	set_modulate(Color(1, 1, 1, 1))

