extends Control


func _ready():
	$PlayButton.grab_focus()


func _on_Timer_timeout():
	MainMusic.play()

