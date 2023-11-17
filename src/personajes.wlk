import wollok.game.*
import objetosUtiles.*
import direcciones.*
import nivelx.*

class Personaje {

	var property estado = self.estadoHabitual()
	var property nivel = null
	var property position = game.at(0, 0)
	var property posicionPrincipio = game.at(0, 0)
	const property llavesRotas = #{}
	var tieneVarita = false
	
	method transformacion()

	method estadoHabitual()

	method llaveEnMano()

	method congelado()

	method entrarEnZonaGuardias()

	method image() = estado.image() + ".png"

	method varitaEnMano()

	method colisionarCon(personaje) {
	}

	method transformarse() {
		estado = self.transformacion()
		game.schedule(10000, { self.estado(self.estadoHabitual())})
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
		return self.puedeOcupar(proxima) && estado.puedeMoverse()
	}

	method puedeOcupar(posicion) {
		return tablero.puedeOcupar(posicion, self)
	}

	method mover(direccion) {
		if (self.sePuedeMover(direccion)) {
			const proxima = direccion.siguiente(self.position())
			self.position(proxima)
		}
	}

	method volverAlPrincipio() {
		self.position((posicionPrincipio))
	}

	method esSolidoPara(personaje) {
		return false
	}

	method esPerseguible() {
		return estado.esPerseguible()
	}

	method puedePasar(puerta) {
		return estado.puedePasar(puerta)
	}

	method serAtrapado() {
		protagonistas.perder()
	}

	method perder() {
		self.congelar()
		game.schedule(3000, { self.reiniciar()})
	}

	method reiniciar() {
		self.volverAlPrincipio()
		estado = self.estadoHabitual()
	}

	method congelar() {
		estado = self.congelado()
	}

	method repararLlave() {
		self.validarReparar()
		estado = self.llaveEnMano()
		llavesRotas.clear()
		estado.tieneLlave()
	}

	method validarReparar() {
		if (not self.sePuedeRepararLlave() and not self.tieneVarita()) {
			self.error("¡Me faltan pedazos de llave!")
		}
	}

	method sePuedeRepararLlave() {
		return self.llavesRotas() == #{ lr1, lr2, lr3, lr4, lr5, lr6 }
	}

	method guardarLlaveRota(objeto) {
		if (objeto.position() == position) {
			llavesRotas.add(objeto)
		}
	}

	method abrirPuertaCerrada(puerta) {
		self.validarAbrirPuerta(puerta)
		puerta.seAbre(self)
		self.estado(self.estadoHabitual())
	}

	method validarAbrirPuerta(puerta) {
		if (not estado.tieneLlave()) {
			self.error("No puedo abrirla")
		}
	}

	
	method llevarVarita(){
		tieneVarita = true
		self.estado(self.varitaEnMano())
	}

}

object harry inherits Personaje {

	override method llaveEnMano() {
		return harryConLlave
	}
	
	override method varitaEnMano() {
		return harryConVarita
	}
	

	override method transformacion() {
		return harryInvisible
	}

	override method estadoHabitual() {
		return harryHumano
	}

	override method entrarEnZonaGuardias() {
		estado.entrarEnZonaGuardias(self)
	}

	override method congelado() { // La idea es poner una imagen distinta para que cuando se lo atrape no se pueda mover más.
		return harryCongelado
	}

}

object sirius inherits Personaje {

	override method varitaEnMano() {
		return siriusConVarita
	}

	override method llaveEnMano() {
		return siriusConLlave
	}

	override method transformacion() {
		return siriusPerro
	}

	override method estadoHabitual() {
		return siriusHumano
	}

	override method entrarEnZonaGuardias() {
		game.say(self, "Me pueden ver!")
			// game.schedule(1500, { self.volverAlPrincipio()})
		self.serAtrapado()
	}

	override method congelado() { // La idea es poner una imagen distinta para que cuando se lo atrape no se pueda mover más.
		return siriusCongelado
	}

}

object protagonistas {

	const property personajes = #{ harry, sirius }

	method perder() {
		personajes.forEach({ personaje => personaje.perder()})
	}

	method congelar() {
		personajes.forEach({ personaje => personaje.congelar()})
	}

	method descongelar() {
		personajes.forEach({ personaje => personaje.estado(personaje.estadoHabitual())})
	}

	method puedenPasarPuerta(puerta) {
		return personajes.all({ personaje => personaje.puedePasar(puerta) })
	}

}

object siriusConLlave {

	method image() = "sirius"

	method puedePasar(puerta) = false

	method esPerseguible() = true

	method tieneLlave() = true

	method puedeMoverse() = true

}

object siriusConVarita{
	
}
object harryConVarita{
	
}

object harryConLlave {

	method image() = "harry"

	method tieneLlave() = true

	method esPerseguible() = true

	method puedePasar(puerta) = false

	method puedeMoverse() = true

}

object harryHumano {

	method image() = "harry"

	method entrarEnZonaGuardias(personaje) {
		game.say(personaje, "Me pueden ver!")
			// game.schedule(1500, { personaje.volverAlPrincipio()})
		personaje.serAtrapado()
	}

	method esPerseguible() = true

	method puedePasar(puerta) = false

	method puedeMoverse() = true

	method tieneLlave() = false

}

object harryInvisible {

	method image() = "harryInvisible"

	method entrarEnZonaGuardias(personaje) {
	}

	method esPerseguible() = false

	method puedePasar(puerta) = false

	method puedeMoverse() = true

	method tieneLlave() = false

}

object harryCongelado {

	method puedeMoverse() = false

	method puedePasar(puerta) = false

	method image() = "harry"

	method entrarEnZonaGuardias(harry) {
	}

	method tieneLlave() = false

	method esPerseguible() = true

}

object caminando {

	method puedeMover() {
	}

}

object siriusHumano {

	method image() = "sirius"
	
	method puedePasar(puerta) = false

	method esPerseguible() = true

	method tieneLlave() = false

	method puedeMoverse() = true

}

object siriusPerro {

	method image() = "siriusPerro"

	method puedePasar(puerta) = true

	method esPerseguible() = false

	method tieneLlave() = false

	method puedeMoverse() = true

}

object siriusPerroLadrando {

	method image() = "siriusPerro"

	method puedePasar(puerta) = true

	method esPerseguible() = true

	method tieneLlave() = false

	method puedeMoverse() = true

}

object siriusCongelado {

	method puedeMoverse() = false

	method image() = "sirius"

	method puedePasar(puerta) = false

	method esPerseguible() = true

}

