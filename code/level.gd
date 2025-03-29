extends Node2D

func update() -> void:
	for path in $Paths.get_children():
		for enemy in path.get_children():
			enemy.move()
	
	for tower in $Towers.get_children():
		tower.shoot()
