extends Node2D

var lives = 3
var score = 0

@onready var hud = $UI/HUD

var get_scene = preload("res://game_over_screen/game_over_screen.tscn")
@onready var ui = $UI

func _ready():
	hud.set_score_label(score)
	hud.get_lives(lives)

func _on_deathzone_area_entered(area):
	area.queue_free()

func _on_player_took_damage():
	lives -= 1
	hud.get_lives(lives)
	if lives == 0:
		$Player.die()
		
		await get_tree().create_timer(1.5).timeout
		
		var gos = get_scene.instantiate()
		gos.set_score(score)
		ui.add_child(gos)


func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died",on_enemy_died)
	add_child(enemy_instance)

func on_enemy_died():
	$EnemyHitSound.play()
	score += 5
	hud.set_score_label(score)


func _on_enemy_spawner_path_enemy_spawn(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.connect("died", on_enemy_died)
	
