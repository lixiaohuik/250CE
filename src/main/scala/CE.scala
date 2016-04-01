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
    pt_value_r: DSPUInt=2
    pt_value_i: DSPUInt=2
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
  val  stored_Weight_r= (0 until pt_number).map(i => Reg(init = DSPUInt(1, width = data_size)))
  val  stored_Weight_i= (0 until pt_number).map(i => Reg(init = DSPUInt(1, width = data_size)))
  val tmp_weight_r = Reg(init = DSPUInt(1, width = data_size))
  val tmp_weight_i = Reg(init = DSPUInt(1, width = data_size))

//determine whether is pilot tone using the position comb type
  val sigCount = Reg(init = DSPUInt(0, width = data_size)
  val PTCount = Reg(init = DSPUInt(0, width = data_size)
  val IsPT = DSPBool(false) //no need here, but needed for other PT position
  if (sigCount !== frame_size ){
      sigCount := sigCount + DSPUInt(1)
      }.otherwise{
          sigCount := DSPUInt(0)
          PTCount := DSPUInt(0)
      }
  if (sigCount%p.pt_position == DSPUInt(1) ){ //input is a PT
      IsPT := DSPBool(true)
      PTcount := PTcount + DSPUInt(1)
      //do calculation here
      tmp_weight_r := stored_Weight_r(PTCount)
      tmp_weight_i := stored_Weight_i(PTCount)
      signalOut_real := tmp_weight_r * signalIn.real.toUInt // toUInt?
      signalOut_imag := tmp_weight_i * signalIn.imag.toUInt // toUInt?
      val error_r = params.pt_value_r - signalOut_real
      val error_i = params.pt_value_i - signalOut_imag
      f_r = params.mu * error_r * signalIn.real.toUInt
      f_i = params.mu * error_i * signalIn.imag.toUInt
      store_Weight_r(PTCount) := alpha * tmp_weight_r + f_r 
      store_Weight_i(PTCount) := alpha * tmp_weight_i + f_i 
      }.otherwise{
          IsPT := DSPBool(false)
          //do calculation here
          tmp_weight_r := stored_Weight_r(PTCount)
          tmp_weight_i := stored_Weight_i(PTCount)
          signalOut_real := tmp_weight_r * signalIn.real.toUInt // toUInt?
          signalOut_imag := tmp_weight_i * signalIn.imag.toUInt // toUInt?
      }
}
