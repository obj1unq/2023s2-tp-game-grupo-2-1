import wollok.game.*
import enemigos.*
import personajes.*
import objetosUtiles.*
import direcciones.*
import musica.*



class Nivel{
//	const property cancion

	method iniciar() {
		self.terminar()
		self.generar()
//		musica.reproducir(self.cancion())
	}
	
		method terminar() { // En vez de hacer un clear, que borra tambíen los datos del tablero, solo saco los visuals
		game.allVisuals().forEach({visual => game.removeVisual(visual)})
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
		celda.generar(game.at(x,y), self)
	}
	
}

object nivel1 inherits Nivel {
	
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
	method generar(position, nivel){}
}

object i{
	method generar(_position, nivel){
		game.addVisual(new CaminoInvalido(position = _position))
	}
}

object tn{
	
	method validarEntrada(personaje){
		if  (not personaje.puedePasarCueva()){
			self.error("No puedo entrar ahi!")
		}
	}
	
	method generar(position, nivel){
		game.addVisual(tunel)
		tunel.position(position)
		
	}
}

object o{
	method generar(position, nivel){
		const oculto = new Oculto(position = position)
		game.addVisual(oculto)
		objetosUsables.agregarObjeto(oculto)
	}
}

object p{
	method generar(position, nivel){
		game.addVisual(new Pared(position = position))
	}
}

object g{

	method generar(position, nivel){
		const guardia = new Guardia(position = position)
		game.addVisual(guardia)
		listaGuardias.agregarGuardia(guardia)
	}
}

object a{
	method generar(position, nivel){
		game.addVisual(new ZonaDeGuardias(position = position))
	}
}

object h{
	method generar(position, nivel){
		harry.position(position)
		game.addVisual(harry)
		harry.nivel(nivel)
	}
}

object s{
	method generar(position, nivel){
		sirius.position(position)
		game.addVisual(sirius)
		sirius.nivel(nivel)
	}
}

object ag{
	method generar(position, nivel){
		a.generar(position, nivel)
		g.generar(position, nivel)
	}
}

object ao{
	method generar(position, nivel){
		a.generar(position, nivel)
		o.generar(position, nivel)
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

