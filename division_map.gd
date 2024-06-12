class_name DivisionMap extends Control

signal selected(this: DivisionMap)

var segment: Segment
var db: SegmentDb
var polyline: Polyline


func init(segment: Segment, db: SegmentDb, on_selected: Callable) -> DivisionMap:
	selected.connect(on_selected)
	self.segment = segment
	self.db = db
	return self


func _ready():
	pass


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				if event.pressed:
					selected.emit(self)


func _on_resized():
	self.polyline = Segment.map_to_polyline(segment.map, db, size.x * 0.6)
	$PolylineNode2D.polyline = polyline
	$PolylineNode2D.position.x = size.x * 0.2
	$PolylineNode2D.position.y = size.y * 0.5
