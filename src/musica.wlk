import wollok.game.*

object musica {

	var cancion = default.cancion()

	method iniciar() {
		self.configuracion()
		game.schedule(20, { cancion.play()})
	}

	method configuracion() {
		cancion.shouldLoop(true)
		cancion.volume(0.5) // poner volumen
	}

	method reproducir(nuevaCancion) {
		if (cancion.played()) {
			self.cambiarSiHay(nuevaCancion)
		} else {
			self.iniciar()
		}
	}
	
	method cambiarSiHay(nuevaCancion){
		if (self.hayCambioDe(nuevaCancion))
			cancion.pause()
			cancion = nuevaCancion.cancion()
			self.configuracion()
			cancion.play()
	}

	method hayCambioDe(nuevaCancion) {
		return cancion != nuevaCancion.cancion()
	}

}

object default {

	const property cancion = game.sound("") // poner nombre de cancion (.mp3)

}

