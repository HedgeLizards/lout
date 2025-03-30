extends Node

var culture: int = 100:
	set(value):
		culture = value
		culture_changed.emit(value)

signal culture_changed(new_culture: int)

func damage_culture(amount):
	culture -= amount
