extends KinematicBody2D

export var direction = -1;
var velocity = Vector2(0, 0);
var speed = 90;

const GRAVITY = 35;

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true;
	$FloorDetector.position.x = $CollisionShape2D.shape.extents.x * direction;
		
func _physics_process(delta):
	
	var flip = false;
	if (is_on_floor() and not $FloorDetector.is_colliding()):
		if (randf() > .3):
			flip = true
			
	if is_on_wall() or flip:
		direction *= -1;
		$AnimatedSprite.flip_h = direction == 1;
		$FloorDetector.position.x = $CollisionShape2D.shape.extents.x * direction;
		
	velocity.y += GRAVITY;

	if (is_on_floor()):
		velocity.x = direction * speed;

	velocity = move_and_slide(velocity, Vector2.UP)


func _on_TopCollisionDetector_body_entered(body):
	$AnimatedSprite.play("squashed");
	speed = 0;
	set_collision_layer_bit(4, false);
	set_collision_mask_bit(0, false);
	$TopCollisionDetector.set_collision_layer_bit(4, false);
	$TopCollisionDetector.set_collision_mask_bit(0, false);
	$SidesCollisionDetector.set_collision_layer_bit(4, false);
	$SidesCollisionDetector.set_collision_mask_bit(0, false);
	$Timer.start()
	body.bounce()


func _on_SidesCollisionDetector_body_entered(body):
	print("side collision");
	body.ouch(position.x);

func _on_Timer_timeout():
	queue_free()
