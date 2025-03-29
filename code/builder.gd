extends Sprite2D

var currency: int = 100
var selected: Tower = null
var tile_position: Vector2i

func try_buy(tower: Tower):
	if tower != null and tower.cost <= currency:
		select(tower)
	else:
		select(null)

func select(tower: Tower):
	selected = tower
	if tower == null:
		visible = false
	else:
		visible = true
		texture = tower.preview

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#var tile_size: Vector2 = Vector2(%Background.tile_set.tile_size) * %Background.scale
		tile_position = %Grid.to_grid(event.global_position)
		global_position = %Grid.to_world(tile_position)

func _unhandled_input(event: InputEvent) -> void:
	if selected != null and event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var tower = selected.scene.instantiate()
		tower.global_position = global_position
		$'../Level'.add_tower(selected, tile_position)
	elif event is InputEventMouseButton and event.pressed and event.button_index == 2:
		select(null)
