class_name Buy
extends Control

enum TowerId {None, Stringed, Drums, Flute}

@export var tower_type: TowerId
var towers: Dictionary[TowerId, Buying.Tower] = {
	TowerId.None: null,
	TowerId.Stringed: Buying.Stringed,
	TowerId.Flute: Buying.Flute,
	TowerId.Drums: Buying.Drums,
}

func _ready() -> void:
	var tower := towers[tower_type]
	if tower != null:
		$Label.text = str(tower.cost)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		$"/root/Buying".try_buy(towers[tower_type])
