extends Node2D

func _on_beat_timer_timeout():
	for path in $Paths.get_children():
		for enemy in path.get_children():
			enemy.move()
	
	for tower in $Towers.get_children():
		tower.shoot()
