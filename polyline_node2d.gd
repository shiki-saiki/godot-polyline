extends Node2D

var polyline: Polyline


func _draw() -> void:
	polyline.draw(self)


func _on_division_map_resized():
	queue_redraw()
