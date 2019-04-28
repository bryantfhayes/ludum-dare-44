extends NinePatchRect

func _on_Purse_gold_changed(gold):
	$Number.text = "$%.2f" % gold
