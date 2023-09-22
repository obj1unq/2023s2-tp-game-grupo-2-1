import wollok.game.*

object oculto {

	var property position = game.at(2, 5)

	method image() = "escondite.png"

	method serUsado(personaje) {
		personaje.ocultarse()
	}

//	method esEquipable() = true

}

