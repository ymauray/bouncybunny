extends CollisionShape2D

func _on_FallZone_body_entered(body):
	print(body);
	get_tree().change_scene("res://Scenes/Level1.tscn");
