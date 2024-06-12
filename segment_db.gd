class_name SegmentDb extends RefCounted

enum Dir {L=180, R=0, U=270, D=90}

const Preset = {
	"Empty": {
		"map": [],
		"color": Color(0.0, 0.0, 0.0, 0.0),
	},
	"A": {
		"map": [["A", 0, 1.0/3.0], ["A", -90, 1.0/3.0], ["A", 0, 1.0/3.0], ["A", 90, 1.0/3.0], ["A", 0, 1.0/3.0]],
		"color": Color.DARK_TURQUOISE,
	},
	"B": {
		"map": [["B", 0, 1.0/3.0], ["B", -60, 1.0/3.0], ["B", 60, 1.0/3.0], ["B", 0, 1.0/3.0]],
		"color": Color.SNOW,
	},
	"C": {
		"map": [["C", -45, 1.0/sqrt(2.0)], ["D", 45, 1.0/sqrt(2.0)]],
		"color": Color.CRIMSON,
	},
	"D": {
		"map": [["C", 45, 1.0/sqrt(2.0)], ["D", -45, 1.0/sqrt(2.0)]],
		"color": Color.CORAL,
	},
	"E": {
		"map": [["E", -30, 1.0/sqrt(3.0)], ["E", 90, 1.0/sqrt(3.0)], ["E", -30, 1.0/sqrt(3.0)]],
		"color": Color.FUCHSIA,
	},
}

var id_next: int = 0
var d_segment: Dictionary = {}
# key: int


func init() -> SegmentDb:
	load_preset()
	return self


func get_segment_list() -> Array:
	return d_segment.values()


func register_segment(type: String, map: Array, width: float, color: Color) -> Segment:
	if d_segment.size() == 2 ** 31 - 1:
		return null
	var segment: Segment = Segment.new()
	segment.type = type
	segment.map = map
	segment.width = width
	segment.color = color
	while d_segment.has(id_next):
		id_next += 1
	segment.id = id_next
	d_segment[id_next] = segment
	id_next += 1
	return segment


func get_id(type: String) -> int:
	for id in d_segment:
		if d_segment[id].type == type:
			return id
	return -1


func get_segment(type: String) -> Segment:
	for segment in d_segment.values():
		if segment.type == type:
			return segment
	return null


func get_segment_by_id(id: int) -> Segment:
	return d_segment[id]


func name_exist(type: String) -> bool:
	for segment in d_segment.values():
		if segment.type == type:
			return true
	return false


func rename_segment(type_old: String, type_new: String) -> bool:
	if name_exist(type_new):
		return false
	var segment: Segment = get_segment(type_old)
	segment.type = type_new
	return true


func load_preset() -> void:
	for type in Preset:
		register_segment(
			type,
			Preset[type].map.duplicate(true),
			2.0,
			Preset[type].color)
