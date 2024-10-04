extends Area2D

func _ready():
		add_to_group("portal")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("tocando el portal")
		body.queue_free()
	pass
