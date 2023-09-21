import wollok.game.*
import objetosUtiles.*
import direcciones.*

object harry {

	var estado = harryHumano
	var objeto = null
	var property position = game.center()

	method image() = estado.image()

	method ocultarse() {
		estado = harryInvisible
	}

	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}

	method sePuedeMover(direccion) {
		const proxima = direccion.siguiente(self.position())
		return self.puedeOcupar(proxima)
	}


	method mover(direccion) {
		const proxima = direccion.siguiente(self.position())
		self.position(proxima)
	}

	method equiparSiPuede(objetoUtil) {
		if (objetoUtil.esEquipable()) {
			objeto = objetoUtil
		} else {
			game.say(self, "No hay nada acá")
		}
	}

	method usarObjeto() {
		if (objeto != null) {
			objeto.serUsado(self)
		} else {
			game.say(self, "No tengo nada para usar")
		}
	}

}

object harryHumano {

	method image() = "harry.png"

}

object harryInvisible {

	method image() = "harryInvisible.png"

}


object caminando {

	method puedeMover() {
	}

}

object siriusHumano {

	method image() {
		return "sirius.png"
	}

}

object siriusPerro {

	method image() {
		return "siriusPerro.png"
	}

}

object sirius {

	var estado = siriusHumano
	var objeto = null
	var property position = game.center()


	method image() = estado.image()

	method ocultarse() {
		estado = siriusPerro
	}

	method equiparSiPuede(objetoUtil) {
		if (objetoUtil.esEquipable()) {
			objeto = objetoUtil
		} else {
			game.say(self, "No hay nada acá")
		}
	}

	method usarObjeto() {
		if (objeto != null) {
			objeto.serUsado(self)
		} else {
			game.say(self, "No tengo nada para usar")
		}
	}

	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}

	method sePuedeMover(direccion) {
		const proxima = direccion.siguiente(self.position())
		return self.puedeOcupar(proxima)
	}


	method mover(direccion) {
		const proxima = direccion.siguiente(self.position())
		self.position(proxima)
	}

}

