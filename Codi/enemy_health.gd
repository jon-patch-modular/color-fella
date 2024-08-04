extends Health


func _on_ceased_to_be():
	queue_free() #possiblement es podria fer servir un timer i desactivar el comportament
