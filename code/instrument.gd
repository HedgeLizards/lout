extends Node2D

@export var projectile_type: PackedScene

func shoot():
	return
	var enemy = $'../../Paths/Path2D/Enemy'
	prints(self, projectile_type)
	var projectile: Projectile = projectile_type.instantiate()
	projectile.target = enemy
	projectile.position = global_position
	$/root/World/Projectiles.add_child(projectile)
