import wollok.game.*
import objetosUtiles.*
import direcciones.*

class Personaje {

	var property estado = self.estadoHabitual()
	var property position = game.at(0, 0)

	method transformacion()
	method estadoHabitual()
	method puedePasar(puerta)
	method entrarEnZonaGuardias()
	method image() = estado.image() + ".png"
	method colisionarCon(personaje) {
	}

	method transformarse() {
		estado = self.transformacion()
		game.schedule(10000, { self.estado(self.estadoHabitual())})
	}

	method puedeOcupar(posicion) {
		return tablero.puedeOcupar(posicion, self)
	}

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

	method volverAlPrincipio() {
		self.position(game.at(0, 0))
	}
	
	method esSolidoPara(personaje) {
		return false
	}

}

object harry inherits Personaje {

	override method transformacion() {
		return harryInvisible
	}

	override method estadoHabitual() {
		return harryHumano
	}

	override method puedePasar(puerta) {
		return false
	}

	override method entrarEnZonaGuardias() {
		estado.entrarEnZonaGuardias(self)
	}

}

object sirius inherits Personaje {

	override method transformacion() {
		return siriusPerro
	}

	override method estadoHabitual() {
		return siriusHumano
	}

	override method puedePasar(puerta) {
		return estado.puedePasar(puerta)
	}

	override method entrarEnZonaGuardias() {
		game.say(self, "Me pueden ver!")
		game.schedule(1500, { self.volverAlPrincipio()})
	}

}


object harryHumano {

	method image() = "harry"

	method entrarEnZonaGuardias(personaje) {
		game.say(personaje, "Me pueden ver!")
		game.schedule(1500, { personaje.volverAlPrincipio()})
	}

}

object harryInvisible {

	method image() = "harryInvisible"

	method entrarEnZonaGuardias(personaje) {
	}

}

object caminando {

	method puedeMover() {
	}

}

object siriusHumano {

	method image() {
		return "sirius"
	}

	method puedePasar(puerta) {
		return false
	}

}

object siriusPerro {

	method image() {
		return "siriusPerro"
	}

	method puedePasar(puerta) {
		return true
	}

}

