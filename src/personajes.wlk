import wollok.game.*
import objetosUtiles.*
import direcciones.*
import nivelx.*
import enemigos.*

class Personaje {

	var property estado = self.estadoHabitual()
	var property position = game.at(0, 0)
	var property posicionPrincipio = game.at(0, 0)
	const property llavesRotas = #{}
	var property tieneVarita = false
	var property nivel = nivelActual
	var property puedeAgarrarVarita = false
	
	method transformacion()

	method estadoHabitual()

	method congelado()

	method entrarEnZonaGuardias()

	method image() = estado.image() + ".png"

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
	
	method abrir(){
		const colisiones = objetosUsables.losQuePertenecen(game.colliders(self))
		self.validarAbrir(colisiones)
		colisiones.head().abrir(self)
	}
	
	method validarAbrir(objetos) {
		if (objetos.isEmpty()) {
			self.error("No tengo nada para abrir")
		}
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
		game.schedule(1500, { self.reiniciar()})
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
		estado.objeto(llave)
		llavesRotas.clear()
	}

	method validarReparar() {
		if (not self.sePuedeRepararLlave() or not self.tieneVarita()) {
			self.error("¡No puedo reparar la llave todavia!")
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

	method contenidoPermitido(){
			puedeAgarrarVarita = true
	}
	
	method obtenerVarita(){
		if (self.puedeAgarrarVarita()){
			tieneVarita = true
			estado.objeto(varita)
		}
	}

	method llevarVarita(){
		tieneVarita = true
		self.estado(self.varitaEnMano())
	}
	
	method estaEnLaMismaPosicionQue(obstaculo){
		return self.position() == obstaculo.position()
	}

}

object harry inherits Personaje {

	var property patronus = 1


	override method llaveEnMano() {
		return harryConLlave
	}

	
//	method usarLlave(puerta){
//		if (self.estaEnLaPuerta(puerta)){
//			puerta.seAbre()
//		}
//	}
	
	
}

object protagonistas {

	const property personajes = #{ harry, sirius }

	method perder() {
		personajes.forEach({ personaje => personaje.perder()})
	}
	
	method hayAlgunoEnLaMismaPosicionQue(obstaculo){
		return personajes.any({ personaje => personaje.estaEnLaMismaPosicionQue(obstaculo)})
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

object harry inherits Personaje {

	var property patronus = 1


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
	
	
	
//	override method varitaEnMano() {
//		return siriusConVarita
//	}
//
//	override method llaveEnMano() {
//		return siriusConLlave
//	}

	method soltar(){
		const colisiones = objetosUsables.losQuePertenecen(game.colliders(self))
		self.validarAbrir(colisiones)
		colisiones.head().tirar(self)
	}
	
	method validarSoltar(objetos) {
		if (objetos.isEmpty() ) {
			self.error("No tengo nada para abrir")
		}
	}

	method tirar(){
		estado.objeto().position(position)
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

// estados normal 

class Estado {
	var property objeto  = nada

	method image() = "" + self + "Con" + self.objeto() + ""
	method esPerseguible() = true
	method puedeMoverse() = true
	method puedePasar(puerta) = true
	
	method tieneLlave() = objeto.esLlave() // o objeto == llave 
	method tieneVarita() = objeto.esVarita()
	
	method entrarEnZonaGuardias(personaje){}

//	
	
}


object harryHumano inherits Estado {
	
	override method entrarEnZonaGuardias(personaje) {
		game.say(personaje, "Me pueden ver!")
			// game.schedule(1500, { personaje.volverAlPrincipio()})
		personaje.serAtrapado()
	}

}


object harryInvisible inherits Estado {
	override method image() = "harryInvisible"
	override method esPerseguible() = false
}

object harryCongelado inherits Estado{
	override method puedeMoverse() = false
}

object siriusHumano inherits Estado {}

object siriusPerro  inherits Estado{

	var property accion = ninguna
	override method puedePasar(puerta) = true
	override method esPerseguible() = accion.esPerseguible()


}

object siriusCongelado inherits Estado{
	
	override method puedeMoverse() = false
}


object ninguna{
	method esPerseguible() = false
}
object ladrido{
	method esPerseguible() = true
}

object nada inherits Objeto{
	
	override method image(){}
	method esLlave() = false
	method esVarita() = false

}

object llave inherits Objeto{
	override method image(){}
	method esLlave() = true 
	method esVarita() = false
}

object caminando {

	method puedeMover() {
	}

}



//
//object harryHumano {
//
//	override method personajeCon() = "harryCon"
//	
//	method estadoConVarita() = harryConLlave
//
//	method entrarEnZonaGuardias(personaje) {
//		game.say(personaje, "Me pueden ver!")
//			// game.schedule(1500, { personaje.volverAlPrincipio()})
//		personaje.serAtrapado()
//	}
//
//	method esPerseguible() = true
//
//	method puedePasar(puerta) = false
//
//	method puedeMoverse() = true
//
//	method tieneLlave() = false
//
//}
//
//object harryInvisible {
//
//	method image() = "harryInvisible"
//
//	method entrarEnZonaGuardias(personaje) {
//	}
//	
//	method estadoConVarita() = self
//
//	method esPerseguible() = false
//
//	method puedePasar(puerta) = false
//
//	method puedeMoverse() = true
//
//	method tieneLlave() = false
//
//}
//
//object harryCongelado {
//
//	method puedeMoverse() = false
//
//	method puedePasar(puerta) = false
//
//	method image() = "harry"
//
//	method entrarEnZonaGuardias(harry) {
//	}
//	
//	method estadoConVarita() = self
//	
//	method tieneLlave() = false
//
//	method esPerseguible() = true
//
//}
//
//object siriusCongelado {
//
//	method puedeMoverse() = false
//
//	method image() = "sirius"
//
//	method puedePasar(puerta) = false
//
//	method esPerseguible() = true
//	method estadoConVarita() = siriusConVarita
//
//}
//
//
//
//object siriusHumano {
//
//	method image() = "sirius"
//	
//	method puedePasar(puerta) = false
//
//	method esPerseguible() = true
//
//	method tieneLlave() = false
//
//	method puedeMoverse() = true
//	
//	method estadoConVarita() = siriusConVarita
//
//}
//
//object siriusPerro {
//
//	method image() = "siriusPerro"
//
//	method puedePasar(puerta) = true
//
//	method esPerseguible() = false
//
//	method tieneLlave() = false
//
//	method puedeMoverse() = true
//	
//	method estadoConVarita() = siriusPerroConVarita
//
//}
//
//object caminando {
//
//	method puedeMover() {
//	}
//
//}
//
//
//
//
//
//// estadosConObjetos
//
//object siriusConLlave {
//
//	method image() = "sirius"
//
//	method puedePasar(puerta) = false
//
//	method esPerseguible() = true
//
//	method tieneLlave() = true
//	method estadoConVarita() = siriusConVarita
//	method puedeMoverse() = true
//
//}
//
//object siriusConVarita{
//	method image() = "siriusConVarita"
//
//	method tieneLlave() = true
//
//	method esPerseguible() = true
//
//	method puedePasar(puerta) = false
//
//	method puedeMoverse() = true
//	method estadoConVarita() = self
//}
//
//object harryConVarita{
//	
//	method image() = "harryConVarita"
//
//	method tieneLlave() = true
//
//	method esPerseguible() = true
//
//	method puedePasar(puerta) = false
//	method estadoConVarita() = self
//	method puedeMoverse() = true
//}
//
//object harryConLlave {
//
//	method image() = "harry"
//
//	method tieneLlave() = true
//
//	method esPerseguible() = true
//
//	method puedePasar(puerta) = false
//
//	method puedeMoverse() = true
//	
//	method estadoConVarita() = harryConVarita
//
//}
//
//
//object siriusPerroLadrando {
//
//	method image() = "siriusPerro"
//
//	method puedePasar(puerta) = true
//
//	method esPerseguible() = true
//
//	method tieneLlave() = false
//	method estadoConVarita() = siriusPerroConVarita
//	method puedeMoverse() = true
//
//}
//object siriusPerroConVarita {
//	
//	method estadoConVarita() = self	
//	method image() = "siriusPerroConVarita"
//	method puedePasar(puerta) = true
//	method esPerseguible()	  = false
//	method tieneLlave() 	  = false
//	method puedeMoverse() 	  = true
//}
//
//
//
//
