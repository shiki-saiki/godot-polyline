class_name Lib extends Object


static func noop() -> void:
	pass


# assert(new.get_parent() == null)
static func node_replace(old: Node, new: Node) -> Node:
	new.name = old.name
	var index: int = old.get_index()
	var parent: Node = old.get_parent()
	parent.remove_child(old)
	parent.add_child(new)
	parent.move_child(new, index)
	return old


static func node_insert(parent: Node, idx: int, node: Node):
	parent.add_child(node)
	parent.move_child(node, idx)


static func node_remove_queue_free(node: Node):
	node.get_parent().remove_child(node)
	node.queue_free()


static func node_idx_remove_queue_free(parent: Node, idx: int):
	var child = parent.get_child(idx)
	parent.remove_child(child)
	child.queue_free()

