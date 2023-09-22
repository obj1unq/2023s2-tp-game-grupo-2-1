import wollok.game.*
import objetosUtiles.*
import direcciones.*

object harry {

	var property estado = harryHumano
	var property objeto = null
	var property position = game.center()

	method image() = estado.image()

	method ocultarse() {
		estado = harryInvisible
		game.schedule(10000, { self.estado(harryHumano)})
	}

	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}

//	method validarEquipar(objetoUtil) {
//		if (not objetoUtil.esEquipable()) {
//			game.say(self, "No hay nada acá")
//		}
//	}
//	method equiparSiPuede(objetoUtil) {
//		self.validarEquipar(objetoUtil)
//		objeto = objetoUtil
//	}
	method usarObjeto() {
		if (self.hayObjeto(oculto)) {
			self.objeto(oculto)
			objeto.serUsado(self)
		} else {
			game.say(self, "No tengo nada para usar")
		}
	}

	method hayObjeto(_objeto) {
		return self.position() == _objeto.position()
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

	var property estado = siriusHumano
	var property objeto = null
	var property position = game.center()

	method image() = estado.image()

	method ocultarse() {
		estado = siriusPerro
		game.schedule(10000, { self.estado(siriusHumano)})
	}

//	validar:
//	method validarEquipar(objetoUtil) {
//		if (not objetoUtil.esEquipable()) {
//			game.say(self, "No hay nada acá")
//		}
//	}
//	method equiparSiPuede(objetoUtil) {
//		self.validarEquipar(objetoUtil)
//		objeto = objetoUtil
//	}
	method usarObjeto() {
		if (self.hayObjeto(oculto)) {
			self.objeto(oculto)
			objeto.serUsado(self)
		} else {
			game.say(self, "No tengo nada para usar")
		}
	}

	method hayObjeto(_objeto) {
		return self.position() == _objeto.position()
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

