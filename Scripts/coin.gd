extends Area2D

signal coin_collected;

var coin_sound = load("res://Assets/Sounds/confirmation_002.ogg")

func _ready():
	coin_sound.loop  = false
	$CoinSound.stream = coin_sound;

func _on_Coin_body_entered(body):
	$CoinSound.play();
	emit_signal("coin_collected");
	set_collision_mask_bit(0, 0);
	$AnimationPlayer.play("Bounce")

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
