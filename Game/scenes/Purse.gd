extends Node

signal gold_changed(gold)

export (float) var seconds_between_interest = 1.0
export (float) var interest_rate = 0.02
export (int) var starting_gold = 0

var gold = 11
var timeSinceLastInterest = 0

func _ready():
	gold = starting_gold
	set_process(true)
	emit_signal("gold_changed", gold)

func _process(delta):
	timeSinceLastInterest += delta
	if timeSinceLastInterest >= seconds_between_interest:
		timeSinceLastInterest = 0
		var interest = interest_rate * gold
		add_gold(interest)

func add_gold(amount):
	gold += amount
	emit_signal("gold_changed", gold)

func remove_gold(amount):
	gold -= amount
	emit_signal("gold_changed", gold)