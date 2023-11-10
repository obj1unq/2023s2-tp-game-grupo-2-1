import wollok.game.*
import enemigos.*
import personajes.*
import objetosUtiles.*
import musica.*

class Nivel {

	const celdas
	const property cancion

	method iniciar() {
		self.terminar()
		self.generar()
		musica.reproducir(self.cancion())
	}

	method terminar() {
		game.clear()
	}

	method generar() {
		(0 .. game.width() - 1).forEach({ x => (0 .. game.height() - 1).forEach({ y => self.generarCelda(x, y)})})
	}

	method generarCelda(x, y) {
		const celda = celdas.get(y).get(x)
		celda.forEach({ objeto => objeto.generar(game.at(x, y))})
	}

}

object _ {

	method generar(position) {
	}

}

object i {

	method generar(position) {
		game.addVisual(new CaminoInvalido(position = position))
	}

}

object tn {

	method validarEntrada(personaje) {
		if (not personaje.puedePasarCueva()) {
			self.error("No puedo entrar ahi!")
		}
	}

	method generar(position) {
		game.addVisual(tunel)
		tunel.position(position)
	}

}

object o {

	method generar(position) {
		const oculto = new Oculto(position = position)
		game.addVisual(oculto)
		objetosUsables.agregarObjeto(oculto)
	}

}

object p {

	method generar(position) {
		game.addVisual(new Pared(position = position))
	}

}

object g {

	method generar(position) {
		const guardia = new Guardia(position = position)
		game.addVisual(guardia)
		listaGuardias.agregarGuardia(guardia)
	}

}

object a {

	method generar(position) {
		game.addVisual(new ZonaDeGuardias(position = position))
	}

}

object h {

	method generar(position) {
		harry.position(position)
		game.addVisual(harry)
	}

}

object s {

	method generar(position) {
		sirius.position(position)
		game.addVisual(sirius)
	}

}

