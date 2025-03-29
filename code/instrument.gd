extends Node2D

@export var projectile_type: PackedScene

func shoot():
	for area in $Area2D.get_overlapping_areas():
		if area.get_parent() is Enemy:
			shoot_at(area.get_parent())

func shoot_at(enemy: Enemy) -> void:
	prints(self, projectile_type)
	var projectile: Projectile = projectile_type.instantiate()
	projectile.target = enemy
	projectile.position = global_position
	$/root/World/Projectiles.add_child(projectile)
