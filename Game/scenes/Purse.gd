extends Node

signal gold_changed(gold)

export (float) var seconds_between_interest = 1.0
export (float) var interest_rate = 0.02
export (int) var starting_gold = 0

var gold = 11
var timeSinceLastInterest = 0
var playtime = 0

func _ready():
	gold = starting_gold
	set_process(true)
	emit_signal("gold_changed", gold)
	var retval = GameManager.connect("save_score", self, "_on_Purse_save_score")

func _process(delta):
	timeSinceLastInterest += delta
	playtime += delta
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
	
func _on_Purse_save_score(uuid):
	var requester = self.owner.get_node("HTTPRequest")
	requester.request("https://veins-of-gold.firebaseio.com/highscores.json", [], true, HTTPClient.METHOD_PATCH, "{\"%s\" : {\"score\" : %f, \"playtime\" : %f }}" % [uuid, gold, playtime])