class_name Projectile extends Sprite2D

var target_pos: Vector2
var target: Node
var start_pos: Vector2
var progress: float = 0.0
var total_flight: float = 0.3
var damage: float = 1


const scene = preload("res://scenes/pling.tscn")

static func create(position, target) -> Projectile:
	var projectile: Projectile = scene.instantiate()
	projectile.target = target
	projectile.position = position
	return projectile

func _ready() -> void:
	start_pos = position
	target_pos = target.position
	var target_sprite = target.get_node('Sprite2D')
	target_pos.y -= target_sprite.texture.get_height() * target_sprite.scale.y / 2
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
