extends HBoxContainer

signal maximum_changed(maximum)

var maximum = 5100.0
var current_health = 1500.0

func initialize(max_value):
	maximum = max_value
	emit_signal("maximum_changed", maximum)
	
func _on_Health_health_changed(new_health):
	animate_value(current_health, new_health)
	update_count_text(new_health)
	current_health = new_health
	
func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()
	if end < start:
		$AnimationPlayer.play("shake")

func update_count_text(value):
	$Count/Number.text = "%3.1f" % (float(value) / 1000)+ '/' + "%3.1f" % (float(maximum) / 1000)

func _on_Health_max_health_changed(health):
	maximum = health
	emit_signal("maximum_changed", maximum)
