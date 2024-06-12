class_name Segment extends RefCounted

var id: int
var type: String
var map: Array # element: [id, angle, length]
var width: float = 1.0
var color: Color = Color.WHITE


func init(type: String, map: Array, width: float, color: Color) -> Segment:
	self.type = type
	self.map = map
	self.width = width
	self.color = color
	return self



static func map_to_polyline(map: Array, db: SegmentDb, scale: float) -> Polyline:
	var polyline := Polyline.new()
	polyline.append_point(0, Vector2.ZERO)
	var prev_point := Vector2.ZERO
	print("scale: ", scale)
	for seg_data in map:
		var point: Vector2 = prev_point + Vector2.from_angle(deg_to_rad(seg_data[1])) * seg_data[2] * scale
		polyline.append_point(db.get_id(seg_data[0]), point)
		prev_point = point
	polyline.db = db
	return polyline

