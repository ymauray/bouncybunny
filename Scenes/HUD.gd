extends CanvasLayer

var coins = 0

func _ready():
	$counter.text = String(coins)

func _on_coin_collected():
	coins += 1;
	_ready();
