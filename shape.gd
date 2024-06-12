class_name Shape extends Object


class Circle extends Shape:
	var center: Vector2
	var radius: float
	
	func has_point(point: Vector2) -> bool:
		return center.distance_to(point) < radius
	
