extends CharacterBody2D

@onready var aniWolf := $AnimatedSprite2D
@onready var move_timer := $Timer
var is_moving = false
var speed = 100
var player: CharacterBody2D = null
var attack_range = 780
var is_in_mundo1 = false
var is_in_mundo2 = false

func _ready():
	if get_tree().current_scene.name == "Mundo1":
		is_in_mundo1 = true
		var mundo1 = get_node("/root/Mundo1")
		player = mundo1.get_node("Player")
	elif get_tree().current_scene.name == "Mundo2":
		is_in_mundo2 = true
		var mundo2 = get_node("/root/Mundo2")
		player = mundo2.get_node("Player")

	# Configurar el temporizador solo si se encuentra el jugador
	if player != null:
		move_timer.wait_time = 0.5  # Asegúrate de que el tiempo no sea cero
		move_timer.start()
		add_to_group("enemigo")
		move_timer.connect("timeout", Callable(self, "_on_Timer_timeout"))


func _on_Timer_timeout():
	is_moving = true
	if is_in_mundo1:
		aniWolf.play("Walk")  
	elif is_in_mundo2:
		aniWolf.play("Walk") 

func _physics_process(delta):
	if player != null:
		var distance_to_player = position.distance_to(player.position)
		
		if distance_to_player > 750:
			aniWolf.play("Attack")
			speed = 250
		elif distance_to_player < attack_range:
			if is_in_mundo2:
				speed = 300
				aniWolf.play("Run")
			else:
				aniWolf.play("Walk")
		else: 
			aniWolf.play("Walk")
			speed = 100
	if is_moving:
		velocity.x = -speed
		move_and_slide()
