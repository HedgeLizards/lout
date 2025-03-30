extends Label

func _ready() -> void:
	text = 'Culture: %d' % Culture.culture
	Culture.culture_changed.connect(on_culture_changed)

func on_culture_changed(new_culture) -> void:
	text = 'Culture: %d' % new_culture
