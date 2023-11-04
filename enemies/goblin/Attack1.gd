extends AttackComponent

@export var damage: float = 10.0
@export var attack_area: Area2D
@export var knockback_distance: float = 150.0
@export var detection_collision_component: AttackCollisionComponent 

@onready var enemy_detected: bool = false


func _on_attack_1_body_entered(body):
	for child in body.get_children():
		if child is HitBoxComponent:
			# get direction from the sword to the body
			var direction_to_damageable = body.global_position - get_parent().global_position
			var direction_sign = sign(direction_to_damageable.x)
			
			do_melee_attack(child, direction_sign)
				
			print_debug(body.name + " took " + str(damage) + " damage.")
			
func do_melee_attack(hit_box: HitBoxComponent, direction: float):
	var knockback = Vector2(knockback_distance * direction, -200)
	hit_box.receive_hit(damage, knockback)

func _on_facing_direction_changed(facing_right: bool):
	if facing_right:
		attack_collision_component.position = attack_collision_component.facing_right_position
		detection_collision_component.position = detection_collision_component.facing_right_position
	else:
		attack_collision_component.position = attack_collision_component.facing_left_position
		detection_collision_component.position = detection_collision_component.facing_left_position
