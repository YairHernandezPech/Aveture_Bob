extends CanvasLayer

var coins = 0

func _ready():
	# Actualizamos el texto con el contador inicial
	$CollectionCoins.text = str(coins)
	
	for coin in get_tree().get_nodes_in_group("coins"):
		coin.connect("coin_collected", Callable(self, "_on_coin_collected"))

func _on_coin_collected():
	print("Moneda recogida")
	coins += 1 
	$CollectionCoins.text = str(coins)
