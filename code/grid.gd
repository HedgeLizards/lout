extends Node2D

var tile_size = Vector2(32, 32)

func _ready() -> void:
	# visible in-editor, but not in-game
	$Cells.visible = false

func to_grid(pos: Vector2) -> Vector2i:
	return $Cells.local_to_map(pos)

func to_world(tilepos: Vector2i) -> Vector2:
	return $Cells.map_to_local(tilepos)
