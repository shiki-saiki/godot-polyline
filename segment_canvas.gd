class_name SegmentCanvas extends Object

var segment_: Segment
var start_: Vector2
var end_: Vector2


func init(segment: Segment, start: Vector2, end: Vector2) -> SegmentCanvas:
	segment_ = segment
	start_ = start
	end_ = end
	return self


func get_length() -> float:
	return start_.distance_to(end_)


func get_direction() -> Vector2:
	return start_.direction_to(end_)


func draw(canvas: CanvasItem):
	canvas.draw_line(start_, end_, segment_.color_, segment_.width_)
