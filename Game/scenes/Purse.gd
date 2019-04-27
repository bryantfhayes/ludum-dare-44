extends Node

signal gold_changed(gold)

var gold = 11

func _ready():
	emit_signal("gold_changed", gold)

func add_gold(amount):
	gold += amount
	emit_signal("gold_changed", gold)

func remove_gold(amount):
	gold -= amount
	emit_signal("gold_changed", gold)