class_name Canvas extends Node2D

var size: Vector2
var segment_db: SegmentDb
var list_polyline: Array[Polyline] = []


func init(segment_db: SegmentDb):
	self.segment_db = segment_db


func _ready():
	size = get_parent().size
	
	insert_segment(0, 3,
		Vector2(size.x * 0.2, size.y * 0.6),
		Vector2(size.x * 0.7, size.y * 0.6))


func _notification(what: int):
	match what:
		NOTIFICATION_SCENE_INSTANTIATED:
			pass


func _draw():
	for polyline in list_polyline:
		polyline.draw(self)


func _on_resized():
	print("resized!!")
	queue_redraw()


func _input(event: InputEvent):
	if event is InputEventKey:
		if event.keycode == KEY_D and event.pressed:
			if 5000 < get_segment_num():
				return
			var t0: int = Time.get_ticks_msec()
			grow()
			var t1: int = Time.get_ticks_msec()
			print("grow: %s ms" % (t1 - t0))
			print("segment count: ", get_segment_num())
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


func get_segment_num() -> int:
	return list_polyline.reduce(
		func(accum: int, pl: Polyline): return accum + pl.get_segment_num(),
		0,
	)


func insert_segment(idx: int, segment_id: int, start: Vector2, end: Vector2):
	var segment: Segment = segment_db.get_segment_by_id(segment_id)
	var polyline := Polyline.new()
	polyline.append_point(0, start)
	polyline.append_point(segment_id, end)
	polyline.db = segment_db
	list_polyline.insert(idx, polyline)


func clear():
	list_polyline.clear()


func grow() -> void:
	for polyline in list_polyline:
		polyline.grow()
	queue_redraw()
