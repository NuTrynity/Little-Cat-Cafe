extends PanelContainer

signal back

func _on_back_pressed():
	hide()
	back.emit()
