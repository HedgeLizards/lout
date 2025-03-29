extends Node2D

func update() -> void:
	for path in $Paths.get_children():
		for enemy in path.get_children():
			enemy.move()
	
	for tower in $Towers.get_children():
		tower.shoot()

func add_tower(blueprint: Tower, pos: Vector2i) -> void:	
	var tower = blueprint.scene.instantiate()
	tower.position = $'../Grid'.to_world(pos)
	prints(pos, tower.position)
	$Towers.add_child(tower)
