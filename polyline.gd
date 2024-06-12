class_name Polyline extends RefCounted

const SELECTED_COLOR: Color = Color.ORANGE
const NEAR_CURSOR_COLOR: Color = Color.CORNFLOWER_BLUE
const NEAR_CURSOR_RADIUS: float = 2.0

var data: Array[PSegment]
var db: SegmentDb


class PSegment:
	var segment_id: int
	var selected: bool = false
	var near_cursor: bool = false
	var endpoint: Vector2


func get_pseg_length(idx: int) -> float:
	return data[idx - 1].endpoint.distance_to(data[idx].endpoint) if idx else 0.0


func get_pseg_direction(idx: int) -> Vector2:
	return data[idx - 1].endpoint.direction_to(data[idx].endpoint) if idx else Vector2.ZERO


func get_point_num() -> int:
	return data.size()


func append_point(segment_id: int, point: Vector2) -> void:
	var pseg := PSegment.new()
	pseg.segment_id = segment_id
	pseg.segment_id = segment_id
	pseg.endpoint = point
	data.push_back(pseg)


func insert_point(idx: int, segment_id: int, endpoint: Vector2) -> void:
	var pseg := PSegment.new()
	pseg.segment_id = segment_id
	pseg.segment_id = segment_id
	pseg.endpoint = endpoint
	data.insert(idx, pseg)


func draw(canvas: CanvasItem) -> void:
	if data.size() == 0:
		return
	var prev_pseg: PSegment = data[0]
	for i in range(1, data.size()):
		var pseg: PSegment = data[i]
		var segment: Segment = db.get_segment_by_id(pseg.segment_id)
		canvas.draw_line(prev_pseg.endpoint, pseg.endpoint, segment.color, segment.width)
		prev_pseg = pseg
	for pseg in data:
		if pseg.near_cursor:
			canvas.draw_circle(pseg.endpoint, 2.0, NEAR_CURSOR_COLOR)
	for pseg in data:
		if pseg.selected:
			canvas.draw_circle(pseg.endpoint, 2.0, SELECTED_COLOR)


func on_cursor_moved(cursor_position: Vector2):
	for pseg in data:
		var distance: float = pseg.endpoint.distance_to(cursor_position)
		pseg.near_cursor = distance < NEAR_CURSOR_RADIUS


func grow():
	if data.size() == 0:
		return
	var prev_end: Vector2 = data[0].endpoint
	var i: int = 1
	while i < data.size():
		var pseg_old_len: float = get_pseg_length(i)
		var pseg_old_dir: Vector2 = get_pseg_direction(i)
		var pseg_old: PSegment = data.pop_at(i)
		var segment: Segment = db.get_segment_by_id(pseg_old.segment_id)
		for seg_data in segment.map:
			var end: Vector2 = prev_end + pseg_old_dir.rotated(deg_to_rad(seg_data[1])) * pseg_old_len * seg_data[2]
			insert_point(i, db.get_id(seg_data[0]), end)
			prev_end = end
			i += 1
