import wollok.game.*
import enemigos.*
import personajes.*
import objetosUtiles.*
import direcciones.*
import musica.*

object nivelActual{ // hago directamente un obj nivel que se acuerde en donde esta.
	var property nivelActual = nivelM
	
	method pasarDeNivel(){
		nivelActual = nivelActual.siguiente()
		nivelActual.iniciar()
	} 
	
	method reiniciar(){
		nivelActual.iniciar()
	}
}

class Nivel{
//	const property cancion
	

	method fondo()
	method accionDeGuardias()
	method siguiente()
	
	method iniciar() {
		self.terminar()
		self.configurar()
		self.generar()
		nivelActual.nivelActual(self)
		self.accionDeGuardias()
//		musica.reproducir(self.cancion())
	}
	

	method configurar() {
		game.boardGround(self.fondo())
		
		
	}
	
	method terminar() { // En vez de hacer un clear, que borra tambíen los datos del tablero, solo saco los visuals
		game.allVisuals().forEach({visual => game.removeVisual(visual)})
		//game.removeTickEvent("caminataGuardias")
	}
	
	method celdas()
		
	method generar(){
		(0..game.width() -1).forEach({x=> 
					(0..game.height() -1).forEach({y=>
								self.generarCelda(x,y)})
		})
		
	}

	method generarCelda(x,y){
		const celda = self.celdas().get(y).get(x)
		celda.generar(game.at(x,y))
	}
	
	method pasarDeNivel(){
		
	}

}


object nivelM inherits Nivel {
	

	override method fondo() =   "nivelM.png"
	
	override method celdas(){
		return
		[[_, _, _, _, _, _, _, _, _, _, p, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, p, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, p, p, p, p, p, p, p, p, p, p, _, _, p, p, p, p, p, p, p, p, p, p, p, p, p, p, _, _],
		 [_, _, p, p, p, p, p, p, p, p, p, p, _, _, p, p, p, p, p, p, p, p, p, p, p, p, p, p, _, _],
		 [_, _, p, _, _, p, p, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, _, _],
		 [_, _, p, _, _, cf, p, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, _, _],
		 [_, _, p, _, _, ss, ss, _, _, _, p, _, _, _, _, _, _, _, _, _, gp, _, _, lr6, _, _, _, p, _, _],
		 [_, _, p, p, p, _, _, p, _, p, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, p, p],
		 [p, p, p, p, p, p, p, p, tn, p, p, _, _, _, _, _, _, gp, _, _, _, _, gp, _, _, _, _, p, p, p],
		 [_, _, _, h, s, _, _, _,   _, _, _, _, _, _, gp, _, _, lr1, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, gp, _, _, _, lr5, _, _, _, _, _],
		 [p, p, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, lr3, _, _, _, _, _, _, p, p, p],
		 [_, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, _, _],
		 [_, _, p, _, o, _, _, _, _, _, _, _, _, _, _, _, gp, _, _, _, _, _, _, _, _, _, _, p, _, _],
		 [_, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, lr2, _, _, gp, lr4, _, _, _, p, _, _],
		 [_, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, _, _],
		 [_, _, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, _, _],
		 [_, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _]
	].reverse()
	}
	
	override method accionDeGuardias(){
		game.onTick(500, "caminataGuardias", {guardiasPerseguidores.perseguir()})
	}

	override method siguiente(){} // hay que agregarle que nivle le sigue

}



object nivel1 inherits Nivel {

	override method fondo() = "background2.png"
	
	override method celdas(){
		return 
		[[i, i, i, i, i, i, i, i, i, i, i, i, i, i, i, m, _, _, _, _, _, _, _, _, _, _, _, _, _, f],
		 [i, i, i, i, i, i, i, i, i, i, i, i, i, i, c, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [i, i, i, i, i, i, i, i, i, c, c, c, i, i, c, m, a, a, a, a, a, ag, a, a, a, a, a, a, a, a],
		 [i, i, i, i, i, i, i, i, i, c, i, c, c, i, c, m, a, a, a, a, a, a, a, a, a, a, a, ag, a, a],
		 [i, i, i, i, i, i, i, i, i, c, c, i, c, c, c, m, a, a, a, ag, a, a, a, a, a, a, a, a, a, a],
		 [i, i, i, i, i, i, i, i, i, i, c, i, i, i, i, m, a, a, a, a, a, ag, a, a, a, a, a, a, a, a],
		 [i, i, i, i, i, i, i, i, i, i, c, c, i, i, i, m, a, a, a, a, a, a, a, ag, a, a, a, a, a, a],
		 [i, i, i, i, c, c, c, c, i, i, i, c, i, i, i, m, ao, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, c, c, c, i, i, c, c, c, i, c, i, i, i, m, a, a, ag, a, a, ag, a, a, a, a, ag, a, a, a],
		 [i, i, c, i, i, i, i, i, i, c, i, c, i, i, i, m, a, a, a, a, a, a, a, a, ag, a, a, a, a, a],
		 [i, i, c, i, i, i, i, i, i, c, c, c, i, i, i, m, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, c, i, i, i, i, i, i, i, i, i, i, i, i, m, a, a, a, a, a, a, a, a, a, a, ag, a, a, a],
		 [i, i, c, i, i, i, i, i, i, i, i, i, i, i, i, m, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, c, c, i, c, c, c, i, i, i, i, i, i, i, m, a, a, a, ag, a, a, a, a, ag, a, a, a, a, a],
		 [i, i, i, c, c, c, i, c, i, i, i, i, i, i, i, m, a, a, a, a, ag, a, a, a, a, a, a, a, a, a],
		 [m, m, m, m, m, m, m, tn, m, m, m, m, m, m, m, m, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, o, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [h, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _]
	].reverse()
	}
	
	override method accionDeGuardias(){
		game.onTick(500, "caminataGuardias", {guardiasNoPerseguidores.perseguir()})
	}
	
	override method generar(){
		super()
		tunel.position(game.at(7, 2))
		game.addVisual(sirius)
		sirius.position(game.at(1,0))
	}
	
	
	override method siguiente(){
		return nivelM
	}
	
}

object nivelC inherits Nivel{
	
	override method fondo() = "background2.png"

	override method celdas(){
		return 
		[[m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m],
		 [m, _, _, _, _, _, _, _, _, _, _, f, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, m],
		 [m, _, _, _, _, _, _, _, _, _, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, _, _, m],
		 [m, _, _, p, m, m, m, m, m, m, m, _, _, _, _, _, _, m, _, m, _, m, _, _, m, _, _, _, _, _, _, m],
		 [m, _, _, _, _, _, _, _, m, _, _, _, _, _, _, _, _, m, _, m, _, m, _, _, m, _, _, _, _, _, _, m],
		 [m, _, _, _, _, _, o, _, _, _, _, _, _, _, _, _, _, m, _, _, _, m, _, _, m, _, _, _, _, _, _, m],
		 [m, a, a, a, ag, a, a, a, m, _, _, _, _, m, _, _, _, m, m, m, _, m, _, _, m, m, m, m, _, _, _, m],
		 [m, _, _, p, m, m, m, m, m, _, _, _, _, m, m, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, m],
		 [m, ag, a, a, a, a, a, a, m, _, _, m, m, m, m, _, _, m, m, m, m, m, m, m, m, _, _, m, m, _, _, m],
		 [m, a, a, a, a, a, a, ag, m, _, _, m, o, _, m, _, _, m, a, a, a, a, ag, a, a, a, a, a, m, _, _, m],
		 [m, m, m, m, m, m, _, _, m, _, _, m, _, _, m, _, _, m, _, _, _, _, _, _, _, _, _, _, m, _, _, m],
		 [m, g, _, _, _, m, _, _, m, _, _, m, _, _, m, _, _, m, _, _, _, _, _, _, _, _, _, _, m, _, _, m],
		 [m, _, m, m, _, m, _, _, _, _, _, m, _, _, m, _, _, m, _, _, _, _, _, _, _, _, _, _, m, _, _, m],
		 [m, _, _, _, _, m, a, a, a, a, a, a, a, a, m, _, _, m, _, _, _, _, _, _, _, _, _, _, m, _, _, m],
		 [m, m, m, m, _, m, m, m, m, m, m, m, m, m, m, _, _, m, m, m, m, m, m, m, m, m, m, m, m, _, _, m],
		 [m, _, _, _, _, _, _, _, _,_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, m],
		 [m, s, h, _, _, _, _, _, _,_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, m],
		 [m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m, m]
		].reverse()
	}
	
	override method accionDeGuardias(){
		game.onTick(1000, "caminataGuardias", {guardiasNoPerseguidores.perseguir()})
	  }
	
	
	override method siguiente(){
		return nivelM
	}
}

object nivelB inherits Nivel{
	
	override method fondo() = "fondoB.png"

	override method celdas(){
		return
		[[_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, _, _],
		 [_, p, _, _, _, _, _, _, _, _, p, _, _, _, _, _, _, _, _, _, _, gp, _, _, _, _, _, p, _, _],
		 [_, p, _, _, _, _, _, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, gp, _, _, p, _, _],
		 [_, p, _, _, _, _, _, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, _, _],
		 [_, p, _, _, _, _, _, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, p, p],
		 [p, p, _, _, _, _, _, _, _, _, p, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, p, p],
		 [_, h, s, _, _, _, _, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, f, _],
		 [p, p, _, _, _, _, _, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, p, p, p, p, p, p],
		 [_, p, _, _, _, _, _, _, _, _, p, p, _, _, _, _, _, _, _, _, _, _, _, _, p, p, p, p, p, _, _],
		 [_, p, _, _, _, _, _, _, _, _, p, _, _, _, _, _, pu, pu, pu, pu, pu, pu, pu, p, p, p, p, p, _, _],
		 [_, p, _, o, _, _, _, _, _, _, p, _, p, _, _, _, pu, _, pu, _, pu, _, pu, pu, _, pu, _, p, _, _],
		 [_, p, _, _, _, _, _, _, _, _, p, tn, p, _, _, _, pu, pu, pu, pu, pu, pu, pu, p, pu, _, pa, p, _, _],
		 [_, p, _, _, _, _, _, _, _, _, _, pu,  p, _, _, _, _, _, _, _, _, _, _, p, _, _, _, p, _, _],
		 [_, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _]
	].reverse()
	}
	
	override method accionDeGuardias(){
		game.onTick(800, "movimientoPuas", {caminoDePuas.activarMovimiento()})
	}
	
	override method siguiente(){
		return nivelM
	}
}


object _{
	method generar(position){}
}


object i{
	method generar(_position){
		const camino = new CaminoInvalido(position = _position)
		game.addVisual(camino)
//		caminosInvalidos.agregarCamino(self)
	}
}

object c{
	method generar(_position){
		const camino = new CaminoValido(position = _position)
		game.addVisual(camino)
		caminosValidos.agregarCamino(camino)
	}
}

object tn{

	
	method generar(position){
		tunel.position(position)
		game.addVisual(tunel)
	}
	
	
}




object o{
	method generar(position){
		const oculto = new Oculto(position = position)
		game.addVisual(oculto)
		objetosUsables.agregarObjeto(oculto)
	}
} 

object p{
	method generar(position){
		game.addVisual(new Pared(position = position))
	}
}

object m{
	method generar(position){
		game.addVisual(new ParedVisible(position = position))
	}
}


object g{

	method generar(position){
		const guardia = new Guardia(position = position)
		game.addVisual(guardia)
		guardiasNoPerseguidores.agregarGuardia(guardia)
	}
}

object gp{

	method generar(position){
		const guardia = new GuardiaPerseguidor(position = position, posicionDeCustodia = position)
		game.addVisual(guardia)   
		guardiasPerseguidores.agregarGuardia(guardia)
	}
	
}


object cf{
		
	method generar (_position){
		cofre.position(_position)
		game.addVisual(cofre)
		objetosUsables.agregarObjeto(cofre)
	}	
	
}


object ss{

    method generar(position){
        const sensor = new SensorCofre(position = position, objetoApuntado = cofre)
        game.addVisual(sensor) 
        objetosUsables.agregarObjeto(sensor)
    }
}

object sp{
    
//    method generar(position){
//        const sensor = new SensorPuerta(position = position, objetoApuntado = puertaNivelM)
//        game.addVisual(sensor) 
//        objetosUsables.agregarObjeto(sensor)
//    }
}

object sl {
	
	method generar(position){
        const sensor = new SensorPuerta(position = position, objetoApuntado = palanca)
        game.addVisual(sensor) 
        objetosUsables.agregarObjeto(sensor)
    }
}


object v{
	method generar (_position){
		varita.position(_position)
		game.addVisual(varita)
		objetosUsables.agregarObjeto(varita)
	}
}

object lr1 inherits LlaveRota{override method image() = "LR1.png"}
object lr2 inherits LlaveRota{override method image() = "LR2.png"}
object lr3 inherits LlaveRota{override method image() = "LR3.png"}
object lr4 inherits LlaveRota{override method image() = "LR4.png"}
object lr5 inherits LlaveRota{override method image() = "LR5.png"}
object lr6 inherits LlaveRota{override method image() = "LR6.png"}	


object a{
	method generar(position){
		game.addVisual(new ZonaDeGuardias(position = position))
	}
}

object h{
	
	
	method generar(position){
		harry.position(position)
		game.addVisual(harry)
		harry.posicionPrincipio(position)
//		harry.nivel(nivel)

	}
}

object s{
	
	method generar(position){
		sirius.position(position)
		game.addVisual(sirius)
		sirius.posicionPrincipio(position)
//		sirius.nivel(nivel)
	}
}


object ag{
	method generar(position){
		a.generar(position)
		g.generar(position)
	}
}

object ao{
	method generar(position){
		a.generar(position)
		o.generar(position)
	}
}

object f{
	method generar(position){
		puertaNivel.position(position)
		game.addVisual(puertaNivel)
	}
}

object pu {
	method generar(position){
		const pua = new Pua(position = position)
		game.addVisual(pua)   
		caminoDePuas.agregarPua(pua)
	}
}

object dn {
	method generar(position){
		const pua = new Pua(position = position)
		game.addVisual(pua) 
	}
}

object pa {
	
	method generar(position){
		const palanc = new Palanca (position = position)
		game.addVisual(palanc)
	}
}

object pl {
	
}