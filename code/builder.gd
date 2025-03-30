extends Sprite2D

var selected: Tower = null
var tile_position: Vector2i

func _ready() -> void:
	Culture.culture_changed.connect(func(_culture): try_select(selected))

func try_select(tower: Tower):
	if tower != null and tower.cost <= Culture.culture:
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
	$'../UI/PanelContainer/VBoxContainer/Buying/CancelBuy'.visible = visible

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#var tile_size: Vector2 = Vector2(%Background.tile_set.tile_size) * %Background.scale
		tile_position = %Grid.to_grid(event.global_position)
		global_position = %Grid.to_world(tile_position)
		if $'../Level'.can_build(tile_position):
			self.modulate = Color.WHITE
		else:
			self.modulate = Color(0.5, 0.5, 0.5, 0.3)

func _unhandled_input(event: InputEvent) -> void:
	if selected != null and event is InputEventMouseButton and event.pressed and event.button_index == 1:
		try_build(selected, tile_position)
	elif event is InputEventMouseButton and event.pressed and event.button_index == 2:
		select(null)

func try_build(blueprint: Tower, tile_position: Vector2i):
	if Culture.culture >= selected.cost and $'../Level'.can_build(tile_position):
		$'../Level'.add_tower(selected, tile_position)
		Culture.culture -= selected.cost
		select(null)
