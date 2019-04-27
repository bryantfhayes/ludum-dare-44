extends NinePatchRect

func _on_Interface_gold_updated(count):
	$Number.text = str(count)
