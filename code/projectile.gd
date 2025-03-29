class_name Projectile extends Sprite2D

var target_pos: Vector2
var target: Node
var start_pos: Vector2
var progress: float = 0.0
var total_flight: float = 0.3
var damage: float = 1


func _ready() -> void:
	start_pos = position
	target_pos = target.position
	target.tree_exited.connect(func(): target = null)

func _process(delta: float) -> void:
	progress = min(progress + delta, total_flight)
	position = lerp(start_pos, target_pos, progress / total_flight)
	if progress == total_flight:
		impact()

func impact() -> void:
	if target != null and is_instance_valid(target):
		target.damage(damage)
	queue_free()
