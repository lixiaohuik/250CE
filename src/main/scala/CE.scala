package CE

// ------- Imports START -- DO NOT MODIFY BELOW
import Chisel.{Complex => _, Mux => _, Reg => _, RegNext => _, RegInit => _, Pipe => _, Mem => _, SeqMem => _,
               Module => _, ModuleOverride => _, when => _, switch => _, is => _, unless => _, Round => _,  _}
import ChiselDSP._
// ------- Imports END -- OK TO MODIFY BELOW


/** Module that supports both fixed and floating point testing */
// assum have the pilot tone first?

class CEParams {
    
  var mu:		Double	= 1.0
  var alpha:		Double	= 1.0
  var pt_position: 	Int	= 4
  var frame_size: 	Int 	= 20
  var min_value:	Double  = -255.0			// DSPFixed uses min value to determine bit width rather than actual bit width
  var max_value: 	Double 	= 255.0				// DSPFixed uses max value to determine bit width rather than actual bit width
  var frac_width:	Int	= 32				// DSPFixed has extra argument for fraction width

  // At some point I'd like to make width > 1 so the pt_values should be vectors rather than one value once that happens
  var pt_value_r: 	DSPFixed = DSPFixed(1.0, frac_width)	
  var pt_value_i: 	DSPFixed = DSPFixed(1.0, frac_width)
  var width: 		Int	= 5			// Currently unused since width is 1

}

class CE[T <: DSPQnm[T]](gen : => T, params : => CEParams) extends GenDSPModule (gen) {

class CEIO [T <: DSPQnm[T]](gen : => T, params : CEParams) extends IOBundle {

  val signalIn_real = DSPFixed(INPUT, params.frac_width, (params.min_value, params.max_value))
  val signalIn_imag = DSPFixed(INPUT, params.frac_width, (params.min_value, params.max_value))
  val signalOut_real = DSPFixed(OUTPUT, params.frac_width, (params.min_value, params.max_value))
  val signalOut_imag = DSPFixed(OUTPUT, params.frac_width, (params.min_value, params.max_value))

}
  override val io = new CEIO(gen, params) 

  val pt_number = (math.ceil(params.frame_size.toDouble/params.pt_position.toDouble)).toInt 
  val stored_Weight_r = Vec.fill(pt_number){RegInit(DSPFixed(1.0, params.frac_width))}
  val stored_Weight_i = Vec.fill(pt_number){RegInit(DSPFixed(1.0, params.frac_width))}
  val tmp_weight_r = DSPFixed(1.0, params.frac_width)
  val tmp_weight_i = DSPFixed(1.0, params.frac_width)
 
//determine whether is pilot tone using the position comb type
  val sigCount = UInt(0)
  val PTCount = UInt(0)
  val IsPT = Bool(false) //no need here, but needed for other PT position
  when (sigCount =/= UInt(params.frame_size) ){
    sigCount := sigCount + UInt(1)
  }.otherwise{
    sigCount := UInt(0)
    PTCount := UInt(0)
  }
  when (sigCount%UInt(params.pt_position) === UInt(1) ){ //input is a PT
    IsPT := Bool(true)
    PTCount := PTCount + UInt(1)
    //do calculation here
    tmp_weight_r := stored_Weight_r(PTCount)
    tmp_weight_i := stored_Weight_i(PTCount)
    io.signalOut_real := tmp_weight_r * io.signalIn_real
    io.signalOut_imag := tmp_weight_i * io.signalIn_imag
    val error_r = params.pt_value_r - io.signalOut_real
    val error_i = params.pt_value_i - io.signalOut_imag
    val f_r = DSPFixed(params.mu, params.frac_width) * error_r * io.signalIn_real
    val f_i = DSPFixed(params.mu, params.frac_width) * error_i * io.signalIn_imag
    stored_Weight_r(PTCount) := DSPFixed(params.alpha, params.frac_width) * tmp_weight_r + f_r
    stored_Weight_i(PTCount) := DSPFixed(params.alpha, params.frac_width) * tmp_weight_i + f_i
  }.otherwise{
    IsPT := Bool(false)
    //do calculation here
    tmp_weight_r := stored_Weight_r(PTCount)
    tmp_weight_i := stored_Weight_i(PTCount)
    io.signalOut_real := tmp_weight_r * io.signalIn_real
    io.signalOut_imag := tmp_weight_i * io.signalIn_imag
  }
}
