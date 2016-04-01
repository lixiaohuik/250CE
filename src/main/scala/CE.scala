package CE

// ------- Imports START -- DO NOT MODIFY BELOW
import Chisel.{Complex => _, Mux => _, Reg => _, RegNext => _, RegInit => _, Pipe => _, Mem => _, SeqMem => _,
               Module => _, ModuleOverride => _, when => _, switch => _, is => _, unless => _, Round => _,  _}
import ChiselDSP._
// ------- Imports END -- OK TO MODIFY BELOW

/** Module that supports both fixed and floating point testing */
// assum have the pilot tone first?

case class CEParams {
    mu: Double=1.0
    alpha: Double=1.0
    pt_position: DSPUInt=3
    frame_size: DSPUInt=20
    data_size: DSPUInt=2
    pt_value: DSPUInt=2
    width: DSPUInt=5
}

class CE[T <: DSPQnm[T]](gen : => T) extends GenDSPModule (gen) {
//class CE(implicit params: CEParams) extends GenDSPModule (gen) {

class CEIO [T <: DSPQnm[T]](gen : => T) extends IOBundle {
//input signal  
  val signalIn = Complex(gen).asInput
  val signalOut_real = DSPUInt (OUTPUT, params.data_size )
  val signalOut_imag = DSPUInt (OUTPUT, params.data_size )
}

  val  pt_number = ceil(params.frame_size/pt_position) //division ?
  val  stored_Weight= (0 until pt_number).map(i => Reg(init = DSPUInt(1, width = data_size)))
  val tmp_weight = Reg(init = DSPUInt(1, width = data_size))

//determine whether is pilot tone using the position comb type
  val sigCount = Reg(init = DSPUInt(0, width = data_size)
  val PTCount = Reg(init = DSPUInt(0, width = data_size)
  val IsPT = DSPBool(false) //no need here, but needed for other PT position
  if (sigCount !== frame_size ){
      sigCount := sigCount + DSPUInt(1)
      if (sigCount%p.pt_position == DSPUInt(1) ){ //input is a PT
      IsPT := DSPBool(true)
      PTcount := PTcount + DSPUInt(1)
      //do calculation here
      tmp_weight := stored_Weight(PTCount)
      signalOut_real := tmp_weight * signalIn.real.toUInt // toUInt?
      val error = params.pt_value - signalOut_real
      f = mu * error * signalIn.real.toUInt
      store_Weight(PTCount) := alpha * tmp_weight + f 
      }.otherwise{
      IsPT := DSPBool(false)
      PTcount := PTcount + DSPUInt(1)
      //do calculation here
      tmp_weight := stored_Weight(PTCount)
      signalOut_real := tmp_weight * signalIn.real.toUInt // toUInt?
      }
  }.otherwise{
      sigCount := DSPUInt(0) //reset the counter for a new frame
      PTCount := DSPUInt(0)
      // same thing 
      if (sigCount%p.pt_position == DSPUInt(1) ){ //input is a PT
      IsPT := DSPBool(true)
      PTcount := PTcount + DSPUInt(1)
      //do calculation here
      tmp_weight := stored_Weight(PTCount)
      signalOut_real := tmp_weight * signalIn.real.toUInt // toUInt?
      val error = params.pt_value - signalOut_real
      f = mu * error * signalIn.real.toUInt
      store_Weight(PTCount) := alpha * tmp_weight + f 
      }.otherwise{
      IsPT := DSPBool(false)
      PTcount := PTcount + DSPUInt(1)
      //do calculation here
      tmp_weight := stored_Weight(PTCount)
      signalOut_real := tmp_weight * signalIn.real.toUInt // toUInt?
      } 
   }

}
