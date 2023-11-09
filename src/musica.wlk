object musica {
	
	var cancion = default.cancion()
	
	method iniciar() {
		self.configuracion()
		game.schedule(20, { cancion.play()}) // cambie el tiempo de arranque
	}

	method reproducir() {
		if (self.estaPausada()) {
			cancion.resume()
		} else {
			cancion.play()
		}
	}

	method configuracion() {
		cancion.shouldLoop(true)
		cancion.volume(0.2)
	}
}

object default {
	const property cancion = game.sound()
}