extends Node2D

enum EnemyType { REGULAR, TANKY, FAST }

const Enemy = preload('res://scenes/enemy.tscn')
const BEATS_DURING_WAVE = 10
const BEATS_BETWEEN_WAVES = 20

var culture: int = 100
var wave = [
	[0, EnemyType.REGULAR],
	[0.5, EnemyType.FAST],
]
# var current_wave = 0
var beats_during_this_wave = -5
var beats_until_spawn = 2.0
var spawn_progress = -beats_until_spawn / 2

func spawn_enemy(type):
	var enemy = Enemy.instantiate()
	
	enemy.type = type
	enemy.h_offset = randf_range(-48, 48)
	enemy.v_offset = randf_range(-48, 48)
	
	$Level/Paths/Path2D.add_child(enemy)

func _on_beat_timer_timeout():
	beats_during_this_wave += 1
	
	if beats_during_this_wave == BEATS_DURING_WAVE:
		beats_during_this_wave = -BEATS_BETWEEN_WAVES
		spawn_progress = -beats_until_spawn / 2
	elif beats_during_this_wave >= 0:
		while spawn_progress + beats_until_spawn <= beats_during_this_wave + 1:
			spawn_progress += beats_until_spawn
			
			var wave_progress_ratio = spawn_progress / BEATS_DURING_WAVE 
			var enemy_type
			
			for phase in wave:
				if wave_progress_ratio >= phase[0]:
					enemy_type = phase[1]
				else:
					break
			
			spawn_enemy(enemy_type)
	
	$Level.update()
