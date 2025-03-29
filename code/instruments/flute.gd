extends Node2D

@export var projectile_type: PackedScene

func shoot():
	var target: Enemy = null
	for area in $Area2D.get_overlapping_areas():
		if area.get_parent() is Enemy:
			var possible_target: Enemy = area.get_parent()
			if (target == null or possible_target.progress_left() < target.progress_left()):
				target = area.get_parent()
	if target != null:
		shoot_at(target)

func shoot_at(enemy: Enemy) -> void:
	var projectile: Projectile = projectile_type.instantiate()
	projectile.target = enemy
	projectile.position = global_position
	$/root/World/Projectiles.add_child(projectile)
