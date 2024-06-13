class_name SegmentInfoLabel extends Label

signal selected(this: SegmentInfoLabel)

var segment: Segment


func init(segment: Segment, on_selected: Callable) -> Label:
	self.segment = segment
	selected.connect(on_selected)
	return self


func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				if event.pressed:
					selected.emit(self)

func _draw() -> void:
	draw_line(size * Vector2(0.25, 0.75), size * Vector2(0.75, 0.75), segment.color, 2.0)
