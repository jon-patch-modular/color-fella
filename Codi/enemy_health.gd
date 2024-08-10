extends Health


func _on_ceased_to_be():
	#TODO: fot una animació to wapa
	$"..".queue_free() #possiblement es podria fer servir un timer i desactivar el comportament
