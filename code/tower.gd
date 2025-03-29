class_name Tower

var cost: int
var scene: Resource
var preview: Resource
func _init(cost: int, scene: Resource, preview: Resource):
	self.cost = cost
	self.scene = scene
	self.preview = preview


static var Guitar: Tower = Tower.new(
	25,
	preload("res://scenes/instruments/guitar.tscn"),
	preload("res://art/instruments/stringed.png"),
)
static var Flute: Tower = Tower.new(
	15,
	preload("res://scenes/instruments/flute.tscn"),
	preload("res://art/instruments/flute.png"),
)
static var Drums: Tower = Tower.new(
	35,
	preload("res://scenes/instruments/drums.tscn"),
	preload("res://art/instruments/drums.png"),
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
