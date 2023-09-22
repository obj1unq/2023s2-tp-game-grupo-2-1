import wollok.game.*

object oculto {

	var property position = game.at(2, 5)

	method image() = "escondite.png"

	method serUsado(personaje) {
		personaje.ocultarse()
	}

}

object objetosUsables {

	const objetosUsables = #{ oculto }

	method objetosUsables() {
		return objetosUsables
	}

	method losQuePertenecen(objetos) {
		return objetos.filter({ objeto => objetosUsables.contains(objeto) })
	}

}

