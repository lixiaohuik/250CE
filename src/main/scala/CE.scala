package CE

// ------- Imports START -- DO NOT MODIFY BELOW
import Chisel.{Complex => _, Mux => _, Reg => _, RegNext => _, RegInit => _, Pipe => _, Mem => _, SeqMem => _,
               Module => _, ModuleOverride => _, when => _, switch => _, is => _, unless => _, Round => _,  _}
import ChiselDSP._
// ------- Imports END -- OK TO MODIFY BELOW


/** Module that supports both fixed and floating point testing */
// assum have the pilot tone first?

case class CEParams (
    
   mu:		Double	= 1.0,
   alpha:	Double	= 1.0,
   pt_position: Int	= 2,
   frame_size: 	Int 	= 4,
   min_value:	Double  = -255.0,			// DSPFixed uses min value to determine bit width rather than actual bit width,
   max_value: 	Double 	= 255.0,				// DSPFixed uses max value to determine bit width rather than actual bit width,
   frac_width:	Int	= 32,				// DSPFixed has extra argument for fraction width,
   frac_width_big:	BigInt	= 16,				// DSPFixed has extra argument for fraction width,

  // At some point I'd like to make width > 1 so the pt_values should be vectors rather than one value once that happens
   //pt_value_r: 	DSPFixed = DSPFixed(1.0, 32),	
   //pt_value_i: 	DSPFixed = DSPFixed(1.0, 32),
   pt_value_r: 	Double = 1.0, 	
   pt_value_i: 	Double = 1.0, 
   width: 		Int	= 5			// Currently unused since width is 1

)

class CE[T <: DSPQnm[T]](gen : => T, p : CEParams) extends GenDSPModule (gen) {

class CEIO [T <: DSPQnm[T]](gen : => T, p : CEParams) extends IOBundle {

  val signalIn_real = DSPFixed(INPUT, p.frac_width, (p.min_value, p.max_value))
  val signalIn_imag = DSPFixed(INPUT, p.frac_width, (p.min_value, p.max_value))
  val signalOut_real = DSPFixed(OUTPUT, p.frac_width, (p.min_value, p.max_value))
  val signalOut_imag = DSPFixed(OUTPUT, p.frac_width, (p.min_value, p.max_value))

}
  override val io = new CEIO(gen, p) 

  val pt_number = (math.ceil(p.frame_size.toDouble/p.pt_position.toDouble)).toInt 
  val stored_Weight_r = Vec.fill(pt_number){RegInit(DSPFixed(1.0, p.frac_width))}
  val stored_Weight_i = Vec.fill(pt_number){RegInit(DSPFixed(1.0, p.frac_width))}

  val pt_value_r = DSPFixed(p.pt_value_r, p.frac_width)
  val pt_value_i = DSPFixed(p.pt_value_i, p.frac_width)

//determine whether is pilot tone using the position comb type
  val sigCount = RegInit(UInt(0,width = 32))
  val PTCount =  RegInit(UInt(0,width = 32))
  val IsPT = Bool(false) //no need here, but needed for other PT position
  when (sigCount =/= UInt(p.frame_size) ){
    sigCount := sigCount + UInt(1)
  }.otherwise{
    sigCount := UInt(0)
    PTCount := UInt(0)
  }
  when (sigCount%UInt(p.pt_position) === UInt(1) ){ //input is a PT
    IsPT := Bool(true)
    PTCount := PTCount + UInt(1)
    //do calculation here
//    println(stored_Weight_r(0))// print the vec
    val tmp_weight_r = stored_Weight_r(PTCount)
//    println(tmp_weight_r)// print the assigned
    val tmp_weight_i = stored_Weight_i(PTCount)
    val signalOut_real_long = tmp_weight_r * io.signalIn_real
    val signalOut_imag_long = tmp_weight_i * io.signalIn_imag
//    println(io.signalOut_real.getRange)
    //io.signalOut_real := signalOut_real_long.shorten(io.signalOut_real.getRange)
    //io.signalOut_imag := signalOut_imag_long.shorten(io.signalOut_imag.getRange)
           io.signalOut_real := signalOut_real_long $$
           //io.signalOut_real := signalOut_real_long.shorten(p.frac_width_big,p.frac_width_big)
           //io.signalOut_imag := signalOut_imag_long.shorten(p.frac_width)
    val error_r = pt_value_r - io.signalOut_real
    val error_i = pt_value_i - io.signalOut_imag
    val f_r = DSPFixed(p.mu, p.frac_width) * error_r * io.signalIn_real
    val f_i = DSPFixed(p.mu, p.frac_width) * error_i * io.signalIn_imag
    val stored_Weight_r_long = DSPFixed(p.alpha, p.frac_width) * tmp_weight_r + f_r
    val stored_Weight_i_long = DSPFixed(p.alpha, p.frac_width) * tmp_weight_i + f_i
    //stored_Weight_r(PTCount) := stored_Weight_r_long.shorten(tmp_weight_r.getRange)
    //stored_Weight_i(PTCount) := stored_Weight_i_long.shorten(tmp_weight_i.getRange)
    //println(stored_Weight_r_long)
    //stored_Weight_r(PTCount) := stored_Weight_r_long.shorten(p.frac_width)
    //stored_Weight_i(PTCount) := stored_Weight_i_long.shorten(p.frac_width)
  }.otherwise {
    IsPT := Bool(false)
    //do calculation here
    val tmp_weight_r = stored_Weight_r(PTCount)
    val tmp_weight_i = stored_Weight_i(PTCount)
    val signalOut_real_long = tmp_weight_r * io.signalIn_real
    val signalOut_imag_long = tmp_weight_i * io.signalIn_imag
    //io.signalOut_real := signalOut_real_long.shorten(io.signalOut_real.getRange)
    //io.signalOut_imag := signalOut_imag_long.shorten(io.signalOut_imag.getRange)
    //io.signalOut_real := signalOut_real_long.shorten(p.frac_width)
    //io.signalOut_imag := signalOut_imag_long.shorten(p.frac_width)
  }
}
