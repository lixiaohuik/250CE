package CE

// ------- Imports START -- DO NOT MODIFY BELOW
import Chisel.{Complex => _, Mux => _, Reg => _, RegNext => _, RegInit => _, Pipe => _, Mem => _, SeqMem => _,
               Module => _, ModuleOverride => _, when => _, switch => _, is => _, unless => _, Round => _,  _}
import ChiselDSP._
// ------- Imports END -- OK TO MODIFY BELOW

/** Module that supports both fixed and floating point testing */
// assum have the pilot tone first?

class CE[T <: DSPQnm[T]](gen : => T) extends GenDSPModule (gen) {

class CEIO [T <: DSPQnm[T]](gen : => T) extends IOBundle {
//input signal  
  val signalIn = Complex(gen).asInput

// position of the pilot tones (0 to 2pi)

// expected value of the pilot tones ??(make it a param?)


}
//get the pilot tone with the position

//compare the pilot tone with the expected value and get the inverse

// repeat for imaginary/real part

}
