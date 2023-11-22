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
	var property puedeAgarrarVarita = false
	
	method transformacion()

	method estadoHabitual()

	method congelado()

	method entrarEnZonaGuardias()

	method image() = estado.image() + ".png"

	method colisionarCon(personaje) {
	}
	
	method llevaVarita(){
		tieneVarita = true
		estado.llevaVarita()
	}
	method transformarse() {
		estado = self.transformacion()
		game.schedule(10000, {self.volverEstadoAnterior() })
	}
	
	method volverEstadoAnterior(){
		if (not estado.tieneNada()){
			self.soltar()
		}
		self.estado(self.estadoHabitual())
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
	
	method soltar(){
		// si tiene el objeto del estado, entonces soltarlo, es decir, generarlo en la posicion actual
		self.validarSoltar()
		estado.objeto().generar(position)
		estado.objeto(nada)
	}
	
	
	method validarSoltar() {
		if (estado.objeto().esNada()) {
			self.error("No tengo nada para soltar")
		}
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
	
		
	method usarHechizo(){
		 self.validarHechizo()			
		 nivelActual.nivelActual().hechizoNivel(self)
	}
	
	method validarHechizo(){
		 if (not self.tieneVarita()){
		 	self.error("¡ No tengo una varita !")
		 }
	}
		
	method repararLlave() {
		self.validarReparar()
		estado.objeto(llave)
		llavesRotas.clear()
	}

	
	method validarReparar() {
		if (not self.sePuedeRepararLlave()) {
			self.error("¡No puedo reparar la llave todavia!")
		}
	}

	method sePuedeRepararLlave() {
		return self.llavesRotas() == #{ lr1, lr2, lr3, lr4, lr5, lr6 }
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
		self.position(posicionPrincipio)
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


	method guardarLlaveRota(objeto) {
		if (objeto.position() == position) {
			llavesRotas.add(objeto)
		}
	}

	method contenidoPermitido(){
			puedeAgarrarVarita = true
	}
	
	method obtenerVarita(){
		
			tieneVarita = true
			estado.objeto(varita)

	}
	
	method tieneLlave(){
		return estado.tieneLlave()
	}

	
	method estaEnLaMismaPosicionQue(obstaculo){
		return self.position() == obstaculo.position()
	}

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

}

object harry inherits Personaje {

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
	method puedePasar(puerta) = false
	method llevaVarita() {
		objeto = varita
	}

	method tieneLlave() = objeto.esLlave() // o objeto == llave 
	method tieneVarita() = objeto.esVarita()
	method tieneNada() = objeto.esNada()
	
	method entrarEnZonaGuardias(personaje){}

//	
	
}


object harryHumano inherits Estado {
	
	override method entrarEnZonaGuardias(personaje) {
		game.say(personaje, "Me pueden ver!")
		game.schedule(1500, { personaje.volverAlPrincipio()})
		personaje.serAtrapado()
	}

}


object harryInvisible inherits Estado {
	override method image() = "harryInvisible"
	override method esPerseguible() = false
}

object harryCongelado inherits Estado{
	override method puedeMoverse() = false
	override method image()= "harryNormal"
}

object siriusHumano inherits Estado {}

object siriusPerro  inherits Estado{

	var property accion = ninguna
	override method puedePasar(puerta) = true
	override method esPerseguible() = accion.esPerseguible()


}

object siriusCongelado inherits Estado{
	override method puedeMoverse() = false
	override method image() = "siriusHumanoConNada"
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
	method esNada()  = true
	method generar(me){}
}

object llave inherits Objeto{
	override method image(){}
	method esLlave() = true 
	method esVarita() = false
	method esNada()  = false
	method generar(me){}
}

object caminando {

	method puedeMover() {
	}

}


