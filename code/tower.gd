class_name Tower

var cost: int
var scene: Resource
var preview: Resource
var preview_position: Vector2
var preview_scale: Vector2
func _init(cost: int, scene: Resource, preview: Resource, preview_position: Vector2, preview_scale: Vector2):
	self.cost = cost
	self.scene = scene
	self.preview = preview
	self.preview_position = preview_position
	self.preview_scale = preview_scale


static var Guitar: Tower = Tower.new(
	25,
	preload("res://scenes/instruments/guitar.tscn"),
	preload("res://art/instruments/SPR_Guitar.png"),
	Vector2(0, -24.625),
	Vector2(0.25, 0.25)
)
static var Flute: Tower = Tower.new(
	15,
	preload("res://scenes/instruments/flute.tscn"),
	preload("res://art/instruments/flute.png"),
	Vector2.ZERO,
	Vector2.ONE,
)
static var Drums: Tower = Tower.new(
	35,
	preload("res://scenes/instruments/drums.tscn"),
	preload("res://art/instruments/SPR_Drums.png"),
	Vector2(0, -31.58),
	Vector2(0.39, 0.39)
)


enum TowerId {None, Guitar, Drums, Flute}

static var towers: Dictionary[TowerId, Tower] = {
	TowerId.None: null,
	TowerId.Guitar: Guitar,
	TowerId.Flute: Flute,
	TowerId.Drums: Drums,
}

static func from_id(tower_id: TowerId) -> Tower:
	return towers[tower_id]
