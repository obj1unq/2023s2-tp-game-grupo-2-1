import wollok.game.*
import enemigos.*
import personajes.*
import objetosUtiles.*
import direcciones.*
import musica.*



class Nivel{
//	const property cancion
	

	method fondo()
	
	method iniciar() {
		self.terminar()
		self.configurar()
		self.generar()
//		musica.reproducir(self.cancion())
	}
	
	method configurar() {
		game.boardGround(self.fondo())
		
		
	}
	
		method terminar() {
		game.clear()
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

}


object nivelM inherits Nivel {
	

	override method fondo() = "nivelM.png"
	
	override method celdas(){
		return
		[[_, _, _, _, _, _, _, _, _, _, p, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, p, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, p, p, p, p, p, p, p, p, p, p, _, _, p, p, p, p, p, p, p, p, p, p, p, p, p, p, _, _],
		 [_, _, p, p, p, p, p, p, p, p, p, p, _, _, p, p, p, p, p, p, p, p, p, p, p, p, p, p, _, _],
		 [_, _, p, _, _, _, _, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, _, _],
		 [_, _, p, _, _, _, _, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, _, _],
		 [_, _, p, _, _, _, _, _, _, _, p, _, _, _, _, _, _, _, _, _, gp, _, _, _, _, _, _, p, _, _],
		 [_, _, p, _, _, _, _, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, p, p],
		 [p, p, p, p, p, _, _, p, tn, p, p, _, _, _, _, _, _, gp, _, _, _, _, gp, _, _, _, _, p, p, p],
		 [_, _, _, h, s, _, _, _, _, _, _, _, _, _, gp, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [p, p, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, gp, _, _, _, _, _, _, p, p, p],
		 [_, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, _, _],
		 [_, _, p, _, o, _, _, _, _, _, _, _, _, _, _, _, gp, _, _, _, _, _, _, _, _, _, _, p, _, _],
		 [_, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, gp, _, _, _, _, p, _, _],
		 [_, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, _, _],
		 [_, _, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, p, _, _],
		 [_, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _]
	].reverse()
	}


}
	
	



object nivel1 inherits Nivel {
	
	override method fondo() = "background.png"
	
	override method celdas(){
		return 
		[[i, i, i, i, i, i, i, i, i, i, i, i, i, i, i, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [i, i, i, i, i, i, i, i, i, i, i, i, i, i, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [i, i, i, i, i, i, i, i, i, _, _, _, i, i, _, p, a, a, a, a, a, ag, a, a, a, a, a, a, a, a],
		 [i, i, i, i, i, i, i, i, i, _, i, _, _, i, _, p, a, a, a, a, a, a, a, a, a, a, a, ag, a, a],
		 [i, i, i, i, i, i, i, i, i, _, _, i, _, _, _, p, a, a, a, ag, a, a, a, a, a, a, a, a, a, a],
		 [i, i, i, i, i, i, i, i, i, i, _, i, i, i, i, p, a, a, a, a, a, ag, a, a, a, a, a, a, a, a],
		 [i, i, i, i, i, i, i, i, i, i, _, _, i, i, i, p, a, a, a, a, a, a, a, ag, a, a, a, a, a, a],
		 [i, i, i, i, _, _, _, _, i, i, i, _, i, i, i, p, ao, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, _, _, _, i, i, _, _, _, i, _, i, i, i, p, a, a, ag, a, a, ag, a, a, a, a, ag, a, a, a],
		 [i, i, _, i, i, i, i, i, i, _, i, _, i, i, i, p, a, a, a, a, a, a, a, a, ag, a, a, a, a, a],
		 [i, i, _, i, i, i, i, i, i, _, _, _, i, i, i, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, _, i, i, i, i, i, i, i, i, i, i, i, i, p, a, a, a, a, a, a, a, a, a, a, ag, a, a, a],
		 [i, i, _, i, i, i, i, i, i, i, i, i, i, i, i, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, _, _, i, _, _, _, i, i, i, i, i, i, i, p, a, a, a, ag, a, a, a, a, ag, a, a, a, a, a],
		 [i, i, i, _, _, _, i, _, i, i, i, i, i, i, i, p, a, a, a, a, ag, a, a, a, a, a, a, a, a, a],
		 [p, p, p, p, p, p, p, tn, p, p, p, p, p, p, p, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, o, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [h, s, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _]
	].reverse()
	}

}

object _{
	method generar(position){}
}

object i{
	method generar(_position){
		game.addVisual(new CaminoInvalido(position = _position))
	}
}

object tn{
	
	method validarEntrada(personaje){
		if  (not personaje.puedePasar(self)){
			self.error("No puedo entrar ahi!")
		}
	}
	
	method generar(position){
		tunel.position(position)
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

object g{

	method generar(position){
		const guardia = new Guardia(position = position)
		game.addVisual(guardia)
		listaGuardias.agregarGuardia(guardia)
	}
}

object gp{

	method generar(position){
		const guardia = new GuardiaPerseguidor(position = position, posicionDeCustodia = position)
		game.addVisual(guardia)   
		game.onTick(500, "", {guardia.perseguir()})
	}
	
}


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
//		harry.nivel(self)
	}
}

object s{
	method generar(position){
		sirius.position(position)
		game.addVisual(sirius)
		sirius.posicionPrincipio(position)
//		sirius.nivel(self)
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

//object nivel2{
//	
//		method generar(){
//		(0..game.width() -1).forEach({x=> 
//					(0..game.height() -1).forEach({y=>
//								self.generarCelda(x,y)})
//		})
//		
//		
//	}
//
//	method generarCelda(x,y){
//		const celda = celdas.get(y).get(x)
//		celda.forEach({objeto => objeto.generar(game.at(x,y))})
//	}
//}

