import wollok.game.*

object pocion {
	
	method image() {
		return "pocion.png"
	}
	method position() {
		return game.at(3,5)
	}
	
	method colision(personaje) {
		personaje.comerVisual(self)	
	}
}
