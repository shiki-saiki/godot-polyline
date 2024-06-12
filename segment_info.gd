class_name SegmentInfo extends Control

var segment: Segment
var _label: SegmentInfoLabel
var _division_map: DivisionMap


func init(segment: Segment, db: SegmentDb, on_label_selected: Callable, on_division_map_selected: Callable) -> SegmentInfo:
	self.segment = segment
	_label.init(segment, on_label_selected)
	_division_map.init(segment, db, on_division_map_selected)
	on_type_changed()
	name = segment.type
	return self


func _notification(what: int):
	match what:
		NOTIFICATION_SCENE_INSTANTIATED:
			_label = $HBoxContainer/Label
			_division_map = $HBoxContainer/DivisionMap


func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				if event.pressed:
					pass


func on_type_changed():
	_label.text = segment.type
