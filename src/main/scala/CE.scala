package CE

// ------- Imports START -- DO NOT MODIFY BELOW
import Chisel.{Complex => _, Mux => _, Reg => _, RegNext => _, RegInit => _, Pipe => _, Mem => _, SeqMem => _,
               Module => _, ModuleOverride => _, when => _, switch => _, is => _, unless => _, Round => _,  _}
import ChiselDSP._
// ------- Imports END -- OK TO MODIFY BELOW


/** Module that supports both fixed and floating point testing */
// assum have the pilot tone first?

case class CEParams (
   interp:      Int     = 0,                   // 0: step , 1 : linear    
   mu:		Double	= 0.1,                 //step size
   alpha:	Double	= 1.0,                 //coefficient of older weight
   pt_position: Int	= 2,                   // # of signals between PT + 1 (pitch?)
   frame_size: 	Int 	= 4,                   // # of sub-carriers
   min_value:	Double  = -127.0,			// DSPFixed uses min value to determine bit width rather than actual bit width,
   max_value: 	Double 	= 127.0,				// DSPFixed uses max value to determine bit width rather than actual bit width,
   frac_width:	Int	= 32,				// DSPFixed has extra argument for fraction width,

  // At some point I'd like to make width > 1 so the pt_values should be vectors rather than one value once that happens
   //pt_value_r: 	DSPFixed = DSPFixed(1.0, 32),	
   //pt_value_i: 	DSPFixed = DSPFixed(1.0, 32),
   pt_value_r: 	Double = 1.0, 	        //pre-set PT value (desired PT value)
   pt_value_i: 	Double = 1.0           //pre-set PT value (desired PT value)  

)

class CE[T <: DSPQnm[T]](gen : => T, p : CEParams) extends GenDSPModule (gen) {

class CEIO [T <: DSPQnm[T]](gen : => T, p : CEParams) extends IOBundle {

  val signalIn_real  = gen.asInput 
  val signalIn_imag  = gen.asInput 
  val signalOut_real = gen.asOutput
  val signalOut_imag = gen.asOutput
//  val signalIn_real = DSPFixed(INPUT, p.frac_width, (p.min_value, p.max_value))
//  val signalIn_imag = DSPFixed(INPUT, p.frac_width, (p.min_value, p.max_value))
//  val signalOut_real = DSPFixed(OUTPUT, p.frac_width, (p.min_value, p.max_value))
//  val signalOut_imag = DSPFixed(OUTPUT, p.frac_width, (p.min_value, p.max_value))

}
  override val io = new CEIO(gen, p) 

  val pt_number = (math.ceil(p.frame_size.toDouble/p.pt_position.toDouble)).toInt 
  val stored_Weight_r = Vec.fill(pt_number){RegInit(double2T(1.0, p.frac_width))}
  val stored_Weight_i = Vec.fill(pt_number){RegInit(double2T(1.0, p.frac_width))}

  val pt_value_r = double2T(p.pt_value_r, p.frac_width)
  val pt_value_i = double2T(p.pt_value_i, p.frac_width)

//determine whether is pilot tone using the position comb type
  val sigCount = RegInit(UInt(0,width = (math.ceil(math.log(p.frame_size)*4)).toInt))
  val PTCount =  RegInit(UInt(0,width = (math.ceil(math.log(pt_number)*4)).toInt))
  val sigPosition =  RegInit(UInt(1,width = (math.ceil(math.log(p.pt_position)*4)).toInt))  //Indicate the signal position in a ( PT DATA) block. so if sigPosition is equal to pt_position, it's a PT, other wise it's the position of the signal, the initial 1 should be assigned to 1 again after the first cycle
//    println(sigCount)
  val IsPT = Bool(false) //no need here, but needed for other PT position
  
  when (sigCount =/= UInt(p.frame_size)){
    sigCount := sigCount + UInt(1)
  }.otherwise{
    sigCount := UInt(0)
    PTCount := UInt(0)
    sigPosition := UInt(0)
  }
 
  //when (sigCount%UInt(p.pt_position) === UInt(1) ) //input is a PT
  when (UInt(sigPosition) === (UInt(p.pt_position)-UInt(1))  || (sigCount === UInt(0))){ //input is a PT
    IsPT := Bool(true)
    PTCount := PTCount + UInt(1)
    sigPosition := UInt(0)
    //do calculation here
//    println(stored_Weight_r(0))// print the vec
    val tmp_weight_r = stored_Weight_r(PTCount)
//    println(tmp_weight_r)// print the assigned
    val tmp_weight_i = stored_Weight_i(PTCount)
    val signalOut_real_long = tmp_weight_r * io.signalIn_real
    val signalOut_imag_long = tmp_weight_i * io.signalIn_imag
    val temp_real_O = signalOut_real_long $(io.signalOut_real.getFracWidth)
    val temp_imag_O = signalOut_imag_long $(io.signalOut_imag.getFracWidth)
    io.signalOut_real := temp_real_O.shorten(io.signalOut_real.getRange)
    io.signalOut_imag := temp_imag_O.shorten(io.signalOut_imag.getRange)
    
    val error_r = pt_value_r - io.signalOut_real
    val error_i = pt_value_i - io.signalOut_imag
    val f_r = double2T(p.mu, p.frac_width) * error_r * io.signalIn_real
    val f_i = double2T(p.mu, p.frac_width) * error_i * io.signalIn_imag
 
    val stored_Weight_r_long = double2T(p.alpha, p.frac_width) * tmp_weight_r + f_r
    val stored_Weight_i_long = double2T(p.alpha, p.frac_width) * tmp_weight_i + f_i
   
    val temp_real_W = stored_Weight_r_long $(tmp_weight_r.getFracWidth)
    
    stored_Weight_r(PTCount) := temp_real_W.shorten(stored_Weight_r(PTCount).getRange)
    val temp_imag_W = stored_Weight_i_long $(tmp_weight_r.getFracWidth)
    stored_Weight_i(PTCount) := temp_imag_W.shorten(stored_Weight_i(PTCount).getRange)
  }.otherwise {
    IsPT := Bool(false)
    sigPosition := sigPosition + UInt(1)
    //do calculation here
        when (UInt(p.interp) === UInt(0)){
            val tmp_weight_r = stored_Weight_r(PTCount)
            val tmp_weight_i = stored_Weight_i(PTCount)

            val signalOut_real_long = tmp_weight_r * io.signalIn_real
            val signalOut_imag_long = tmp_weight_i * io.signalIn_imag
            val temp_real_O = signalOut_real_long $(io.signalOut_real.getFracWidth)
            val temp_imag_O = signalOut_imag_long $(io.signalOut_imag.getFracWidth)
            io.signalOut_real := temp_real_O.shorten(io.signalOut_real.getRange)
            io.signalOut_imag := temp_imag_O.shorten(io.signalOut_imag.getRange)
        }.otherwise {
//            val next_w = sigPosition/UInt(p.pt_position)
//            val current_w = UInt(1) - next_w
//	    println (current_w)
//            val tmp_weight_r = stored_Weight_r(PTCount)*current_w
	     // +stored_Weight_r(PTCount + UInt(1)) * next_w
            val tmp_weight_i = stored_Weight_i(PTCount)

//          val signalOut_real_long = tmp_weight_r * io.signalIn_real
            val signalOut_imag_long = tmp_weight_i * io.signalIn_imag
//     //     println (signalOut_real_long)
//     //       val temp_real_O = signalOut_real_long $(p.frac_width)
            val temp_imag_O = signalOut_imag_long $(io.signalOut_imag.getFracWidth)
       //     //io.signalOut_real := temp_real_O.shorten(io.signalOut_real.getRange)
            io.signalOut_imag := temp_imag_O.shorten(io.signalOut_imag.getRange)
        }
//        println (test)
//        println (test.getFracWidth)
//        println (test.getIntWidth)
//        println (io.signalOut_real.getFracWidth)
//        println (io.signalOut_real.getIntWidth)
        //io.signalOut_real := signalOut_real_long.shorten(io.signalOut_real.getRange)
        //io.signalOut_imag := signalOut_imag_long.shorten(io.signalOut_imag.getRange)
        //io.signalOut_real := signalOut_real_long.shorten(p.frac_width)
        //io.signalOut_imag := signalOut_imag_long.shorten(p.frac_width)
  }
}
