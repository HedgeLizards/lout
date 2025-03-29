extends Node2D

var tile_size = Vector2(32, 32)

func _ready() -> void:
	# visible in-editor, but not in-game
	$Cells.visible = false

func to_grid(pos: Vector2) -> Vector2i:
	return (pos / tile_size).round()

func to_world(tilepos: Vector2i) -> Vector2:
	return Vector2(tilepos) * tile_size
