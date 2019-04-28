extends Node

signal health_changed(health)
signal max_health_changed(health)
signal health_depleted

var health = 1500
export(int) var max_health = 5100

func _ready():
	emit_signal("health_changed", health)
	emit_signal("max_health_changed", max_health)
	var retval = GameManager.connect("regen_blood", self, "_on_Health_regen_blood")

func take_damage(amount):
	health -= amount
	health = max(0, health)
	emit_signal("health_changed", health)

func heal(amount):
	health += amount
	health = min(health, max_health)
	emit_signal("health_changed", health)

func _on_Health_regen_blood(amount):
	heal(amount)
