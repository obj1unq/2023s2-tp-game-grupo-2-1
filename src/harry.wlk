import wollok.game.*

object harry {

	method position() = game.center()

	method image() = "harryFrente.png"

	method comerPocion(pocion) {
		self.comer(pocion)
		game.removeVisual(pocion)
	}

	method comer(pocion) {
		
	}

}