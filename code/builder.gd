extends Sprite2D

var selected: Buying.Tower = null

func select(tower: Buying.Tower):
	selected = tower
	if tower == null:
		visible = false
	else:
		visible = true
		texture = tower.preview

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var tile_size: Vector2 = Vector2(%Background.tile_set.tile_size) * %Background.scale
		global_position = (event.global_position / tile_size).round() * tile_size

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		prints(selected, event)
	if selected != null and event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var tower = selected.scene.instantiate()
		tower.global_position = global_position
		%Towers.add_child(tower)
