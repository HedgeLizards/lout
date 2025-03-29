extends Node2D

const Enemy = preload('res://scenes/enemy.tscn')

func spawn_enemy():
	var enemy = Enemy.instantiate()
	
	enemy.h_offset = randf_range(-16, 16)
	enemy.v_offset = randf_range(-16, 16)
	
	$Level/Paths/Path2D.add_child(enemy)

func _on_beat_timer_timeout():
	spawn_enemy()
	
	$Level.update()
