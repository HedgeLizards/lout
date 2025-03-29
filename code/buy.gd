class_name Buy
extends Control

@export var tower_type: Tower.TowerId
@onready var tower: Tower = Tower.from_id(tower_type)

func _ready() -> void:
	if tower != null:
		$Label.text = str(tower.cost)
	Culture.culture_changed.connect(check_afford)
	check_afford(Culture.culture)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		$/root/World/Builder.try_select(tower)

func check_afford(culture: int) -> void:
	if tower == null or tower.cost <= culture:
		self_modulate = Color.WHITE
		$Label.self_modulate = Color.WHITE
	else:
		self_modulate = Color.WEB_GRAY
		$Label.self_modulate = Color.CRIMSON
		
