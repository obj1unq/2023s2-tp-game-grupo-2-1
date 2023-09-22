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

	// validars:
	method validarEquipar(objetoUtil) {
		if (not objetoUtil.esEquipable()) {
			game.say(self, "No hay nada acá")
		}
	}

	method validarUsarObjeto() {
		if (objeto == null) {
			game.say(self, "No tengo nada para usar")
		}
	}

	method equiparSiPuede(objetoUtil) {
		self.validarEquipar(objetoUtil)
		objeto = objetoUtil
	}

	method usarObjeto() {
		self.validarUsarObjeto()
		objeto.serUsado(self)
	}

	method sePuedeMover(direccion) {
		const proxima = direccion.siguiente(self.position())
		return self.puedeOcupar(proxima)
	}

	method mover(direccion) {
		if (self.sePuedeMover(direccion)) {
			const proxima = direccion.siguiente(self.position())
			self.position(proxima)
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

	// validars:
	method validarEquipar(objetoUtil) {
		if (not objetoUtil.esEquipable()) {
			game.say(self, "No hay nada acá")
		}
	}

	method validarUsarObjeto() {
		if (objeto == null) {
			game.say(self, "No tengo nada para usar")
		}
	}

	method equiparSiPuede(objetoUtil) {
		self.validarEquipar(objetoUtil)
		objeto = objetoUtil
	}

	method usarObjeto() {
		self.validarUsarObjeto()
		objeto.serUsado(self)
	}

	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}

	method sePuedeMover(direccion) {
		const proxima = direccion.siguiente(self.position())
		return self.puedeOcupar(proxima)
	}

	method mover(direccion) {
		if (self.sePuedeMover(direccion)) {
			const proxima = direccion.siguiente(self.position())
			self.position(proxima)
		}
	}

}

