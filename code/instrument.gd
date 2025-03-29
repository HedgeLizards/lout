extends Node2D

@export var num_notes: int = 1

func shoot():
	var targets: Array[Enemy] = []
	for area in $Area2D.get_overlapping_areas():
		if area.get_parent() is Enemy:
			var possible_target: Enemy = area.get_parent()
			if len(targets) < num_notes:
				targets.push_back(possible_target)
			else:
				for i in len(targets):
					if possible_target.progress_left() < targets[i].progress_left():
						var swap_target = targets[i]
						targets[i] = possible_target
						possible_target = swap_target
	for target in targets:
		shoot_at(target)

func shoot_at(enemy: Enemy) -> void:
	var projectile: Projectile = Projectile.create(global_position, enemy)
	$/root/World/Projectiles.add_child(projectile)
