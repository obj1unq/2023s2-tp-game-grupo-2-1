import wollok.game.*
import objetosUtiles.*
import direcciones.*

object harry {

	var property estado = harryHumano
	var property position = game.center()

	method image() = estado.image()

	method ocultarse() {
		estado = harryInvisible
		game.schedule(10000, { self.estado(harryHumano)})
	}

	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}

//	method equiparSiPuede(objetoUtil) {
//		if (not objetoUtil.esEquipable()) {
//			game.say(self, "No hay nada acá")
//		}else{
//		objeto = objetoUtil
//		}
//	}
	method usarObjeto() {
		const colisiones = objetosUsables.losQuePertenecen(game.colliders(self))
		self.validarUso(colisiones)
		colisiones.head().serUsado(self)
	}

	method validarUso(objetos) {
		if (objetos.isEmpty()) {
			self.error("No tengo nada para usar")
		}
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

	method colisionasteConHarry() {
	}

	method colision(objeto) {
		objeto.colisionasteConHarry(self)
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
		return "sirius"
	}

}

object siriusPerro {

	method image() {
		return "siriusPerro"
	}

}

object sirius {

	var property estado = siriusHumano
	var property position = game.center()

	method image() = estado.image() + ".png"

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
		const colisiones = objetosUsables.losQuePertenecen(game.colliders(self))
		self.validarUso(colisiones)
		colisiones.head().serUsado(self)
	}

	method validarUso(objetos) {
		if (objetos.isEmpty()) {
			self.error("No tengo nada para usar")
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
		if (self.sePuedeMover(direccion)) {
			const proxima = direccion.siguiente(self.position())
			self.position(proxima)
		}
	}

}

