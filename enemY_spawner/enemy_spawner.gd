extends Node2D

signal enemy_spawned(enemy_instance)
signal path_enemy_spawn(path_enemy_instance)

var enemy_scene = preload("res://enemy_01/enemy_01.tscn")
var path_enemy_scene = preload("res://path_enemy/path_enemy.tscn")

@onready var spawn_position = $SpawnPositions

func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var spawn_positions_array = spawn_position.get_children()
	var random_spawn_positions = spawn_positions_array.pick_random()
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_spawn_positions.global_position
	emit_signal("enemy_spawned",enemy_instance)
	#add_child(enemy_instance)


func _on_path_enemy_timer_timeout():
	spawn_path_enemy()

func spawn_path_enemy():
	var path_enemy_instance = path_enemy_scene.instantiate()
	emit_signal("path_enemy_spawn", path_enemy_instance)
