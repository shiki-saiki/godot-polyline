class_name SegmentEditor extends Node2D

var size: Vector2
var segment_db_: SegmentDb
var list_segment: Array[SegmentCanvas] = []


func init(segment_db: SegmentDb):
	segment_db_ = segment_db


func _ready():
	size = get_parent().size
	$ColorRect.size = size
	
	insert_segment(0, "C",
		Vector2(size.x * 0.2, size.y * 0.6),
		Vector2(size.x * 0.7, size.y * 0.6))


func _notification(what: int):
	match what:
		NOTIFICATION_SCENE_INSTANTIATED:
			pass


func _draw():
	for seg in list_segment:
		seg.draw(self)


func _on_resized():
	queue_redraw()


func _input(event: InputEvent):
	if event is InputEventKey:
		if event.keycode == KEY_G and event.pressed:
			pass
	elif event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				if event.pressed:
					pass
			MOUSE_BUTTON_WHEEL_DOWN:
				if event.pressed:
					scale *= 30.0 / 32.0
			MOUSE_BUTTON_WHEEL_UP:
				if event.pressed:
					scale /= 30.0 / 32.0
	elif event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			position += event.relative
		else:
			var vertex: Vector2
			for segment in list_segment:
				var local_p: Vector2 = global_transform * event.position
				if segment.end_.distance_to(local_p) < 4.0:
					vertex = segment.end_
					break


func insert_segment(idx: int, type: String, start: Vector2, end: Vector2):
	var segment: Segment = segment_db_.get_segment(type)
	list_segment.insert(idx, SegmentCanvas.new().init(segment, start, end))


func clear():
	list_segment.clear()

