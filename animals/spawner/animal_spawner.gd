extends Node2D

class_name AnimalSpawner

@export var spawner_id: int = 0
@export var spawn_interval: float = 10.0
@export var spawn_range: int = 20

@onready var boar = preload("res://animals/boar/boar.tscn")
@onready var chicken_w = preload("res://animals/chicken/chicken_white.tscn")
@onready var chicken_lb = preload("res://animals/chicken/chicken_light_brown.tscn")
@onready var chicken_db = preload("res://animals/chicken/chicken_dark_brown.tscn")
@onready var chicken_b = preload("res://animals/chicken/chicken_black.tscn")

@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = get_node("/root/starting_map/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", _on_timer_timeout)
	timer.wait_time = spawn_interval
	timer.start()

func _on_timer_timeout():
	if check_if_activated():
		var choice: int = randi_range(1, 100)
		var animal_instance
		if choice <= 12:
			animal_instance = boar.instantiate()
		elif 12 < choice and choice <= 34:
			animal_instance = chicken_w.instantiate()
		elif 34 < choice and choice <= 56:
			animal_instance = chicken_lb.instantiate()
		elif 56 < choice and choice <= 78:
			animal_instance = chicken_w.instantiate()
		else:
			animal_instance = chicken_lb.instantiate()
		
		add_child(animal_instance)
		animal_instance.global_position = self.position
		
		var rand_point = randi_range(-spawn_range, spawn_range)
		animal_instance.global_position.x += rand_point
	
	timer.start()

func check_if_activated():
	if len(get_children()) < 15:
		if spawner_id == player.current_camp_id:
			return true
	return false
