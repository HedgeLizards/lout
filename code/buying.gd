extends Node


var currency: int = 1000
var selected: Tower = null

class Tower:
	var cost: int
	var scene: Resource
	var preview: Resource
	func _init(cost: int, scene: Resource, preview: Resource):
		self.cost = cost
		self.scene = scene
		self.preview = preview


var Stringed: Tower = Tower.new(
	25,
	preload("res://scenes/instruments/stringed.tscn"),
	preload("res://art/instruments/stringed.png"),
)
var Flute: Tower = Tower.new(
	15,
	preload("res://scenes/instruments/flute.tscn"),
	preload("res://art/instruments/flute.png"),
)
var Drums: Tower = Tower.new(
	35,
	preload("res://scenes/instruments/drums.tscn"),
	preload("res://art/instruments/drums.png"),
)


func try_buy(tower: Tower):
	if tower != null and tower.cost <= currency:
		$/root/World/Builder.select(tower)
	else:
		$/root/World/Builder.select(null)
