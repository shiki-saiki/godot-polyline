extends Control

var segment_db: SegmentDb
var canvas: Canvas
var segment_db_vis: SegmentDbVis


func _init():
	segment_db = SegmentDb.new()


func _notification(what: int):
	match what:
		NOTIFICATION_SCENE_INSTANTIATED:
			canvas = $Canvas
			segment_db_vis = $HBoxContainer/SegmentDbVis
			
			segment_db = SegmentDb.new().init()
			canvas.init(segment_db)
			segment_db_vis.init(segment_db, _on_segment_info_label_selected, _on_segment_info_division_map_selected)


func _unhandled_input(event: InputEvent):
	if event is InputEventKey:
		match event.keycode:
			KEY_Q:
				if event.pressed:
					segment_db_vis.visible = !segment_db_vis.visible


func _on_segment_info_label_selected(label: Label):
	canvas.clear()
	canvas.insert_segment(0, segment_db.get_id(label.segment.type), Vector2(canvas.size.x * 0.1, canvas.size.y * 0.5),  Vector2(canvas.size.x * 0.9, canvas.size.y * 0.5))
	canvas.queue_redraw()


func _on_segment_info_division_map_selected(division_map: DivisionMap):
	pass
