extends Node2D

var towers: Dictionary[Vector2i, Node]

func _ready() -> void:
	for tower in $Towers.get_children():
		towers[tower.tile_pos] = tower
		tower.get_node('AudioStreamPlayer').play()
	# visible in-editor, but not in-game
	$Buildable.visible = false

func update() -> void:
	$Waves.spawn()
	
	for path in $Paths.get_children():
		for enemy in path.get_children():
			enemy.move()
	
	for tower in $Towers.get_children():
		tower.shoot()

func can_build(pos) -> bool:
	return not towers.has(pos) and $Buildable.get_cell_source_id(pos) >= 0

func add_tower(blueprint: Tower, pos: Vector2i) -> void:
	var tower = blueprint.scene.instantiate()
	tower.position = $'../Grid'.to_world(pos)
	$Towers.add_child(tower)
	towers[pos] = tower
