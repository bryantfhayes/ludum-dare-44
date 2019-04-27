extends Node

signal health_changed(health)
signal max_health_changed(health)
signal health_depleted

var health = 1500
export(int) var max_health = 5100

func _ready():
	health = max_health
	emit_signal("health_changed", health)
	emit_signal("max_health_changed", max_health)

func take_damage(amount):
	health -= amount
	health = max(0, health)
	emit_signal("health_changed", health)

func heal(amount):
	health += amount
	health = max(health, max_health)
	emit_signal("health_changed", health)