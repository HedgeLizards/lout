class_name Buy
extends Control

@export var tower_type: Tower.TowerId

func _ready() -> void:
	var tower := Tower.from_id(tower_type)
	if tower != null:
		$Label.text = str(tower.cost)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		$/root/World/Builder.try_buy(Tower.from_id(tower_type))
