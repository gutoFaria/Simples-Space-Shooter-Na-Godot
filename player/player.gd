extends CharacterBody2D

signal took_damage

var rocked_scene = preload("res://rocket/rocket.tscn")
var speed = 300
@onready var rocket_container = $RocketContainer #get_node("RocketContainer")

func _process(delta):
	if Input.is_action_just_pressed("shooter"):
		shoot()

func _physics_process(delta):
	move()
	limit_player()

func move():
	velocity = Vector2(0,0)
	if Input.is_action_pressed("move_right"):
		velocity.x  = speed
	if Input.is_action_pressed("move_left"):
		velocity.x  = -speed
	if Input.is_action_pressed("move_up"):
		velocity.y  = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y  = speed
	
	move_and_slide()

func limit_player():
	var screen_size = get_viewport_rect().size
	
	global_position = global_position.clamp(Vector2(0,0), screen_size)

func shoot():
	$PlayerShoot.play()
	#var rocket_scene = preload("res://rocket/rocket.tscn")
	var rocket_instance = rocked_scene.instantiate()
	#add_child(rocket_instance)
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 25

func take_damage():
	emit_signal("took_damage")

func die():
	queue_free()
