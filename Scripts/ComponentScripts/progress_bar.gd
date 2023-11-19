extends ProgressBar
class_name CustomProgressBar

func _ready():
	set_color()
	
func set_color():
	var sb = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("a7cc52")
