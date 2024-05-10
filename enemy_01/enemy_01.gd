extends Area2D

signal died

@export var speed = 0

func _physics_process(delta):
	speed = randf_range(100,200)
	global_position.x -= speed * delta

func _on_visible_notifier_screen_exited():
	#queue_free()
	pass

func die():
	emit_signal("died")
	queue_free()

func _on_body_entered(body):
	body.take_damage()
	die()
