class_name SegmentDbVis extends Control

const SegmentInfoScn = preload("res://segment_info.tscn")

var segment_db_: SegmentDb
var segment_list: Array
var on_segment_info_label_selected_: Callable
var on_segment_info_division_map_selected_: Callable
var _list_segment_info: VBoxContainer


func init(segment_db: SegmentDb, on_segment_info_label_selected: Callable, on_segment_info_division_map_selected: Callable) -> SegmentDbVis:
	segment_db_ = segment_db
	segment_list = segment_db.get_segment_list()
	on_segment_info_label_selected_ = on_segment_info_label_selected
	on_segment_info_division_map_selected_ = on_segment_info_division_map_selected
	create_list()
	return self


func _ready():
	pass


func _notification(what: int):
	match what:
		NOTIFICATION_SCENE_INSTANTIATED:
			_list_segment_info = $VBoxContainer


func _gui_input(event: InputEvent):
	if event is InputEventKey:
		match event.keycode:
			KEY_Q:
				if event.pressed:
					pass


func create_list():
	for i in segment_list.size():
		if i == 0:
			continue
		var segment: Segment = segment_list[i]
		var si: SegmentInfo = SegmentInfoScn.instantiate()
		si.init(segment, segment_db_, on_segment_info_label_selected_, on_segment_info_division_map_selected_)
		_list_segment_info.add_child(si)
