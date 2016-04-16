package CE
//seperating the blocks

// ------- Imports START -- DO NOT MODIFY BELOW
import Chisel.{Complex => _, Mux => _, Reg => _, RegNext => _, RegInit => _, Pipe => _, Mem => _, SeqMem => _,
               Module => _, ModuleOverride => _, when => _, switch => _, is => _, unless => _, Round => _,  _}
import ChiselDSP._
// ------- Imports END -- OK TO MODIFY BELOW


/** Module that supports both fixed and floating point testing */
// assum have the pilot tone first?

case class CEParams (
   interp:      Int     = 0,                   // 0: step , 1 : linear    
   algorithm:   Int     = 1,                   // 0: lms, 1: sign
   mu:		Double	= 0.1,                 //step size
   alpha:	Double	= 1.0,                 //coefficient of older weight
   pt_position: Int	= 2,                   // # of signals between PT + 1 (pitch?)
   frame_size: 	Int 	= 4,                   // # of sub-carriers
   min_value:	Double  = -127.0,			// DSPFixed uses min value to determine bit width rather than actual bit width,
   max_value: 	Double 	= 127.0,				// DSPFixed uses max value to determine bit width rather than actual bit width,
   frac_width:	Int	= 20,				// DSPFixed has extra argument for fraction width,
   int_width:	Int	= 3,				// DSPFixed has extra argument for fraction width,

  // At some point I'd like to make width > 1 so the pt_values should be vectors rather than one value once that happens
   //pt_value_r: 	DSPFixed = DSPFixed(1.0, 32),	
   //pt_value_i: 	DSPFixed = DSPFixed(1.0, 32),
   pt_value_r: 	Double = 1.0, 	        //pre-set PT value (desired PT value)
   pt_value_i: 	Double = 1.0           //pre-set PT value (desired PT value)  
)

class LMS[T <: DSPQnm[T]](gen : => T, p : CEParams) extends GenDSPModule (gen) {

    class LMSIO [T <: DSPQnm[T]](gen : => T, p : CEParams) extends IOBundle {
    
      val signalIn_real  = gen.cloneType(p.int_width,p.frac_width).asInput 
      val signalIn_imag  = gen.cloneType(p.int_width,p.frac_width).asInput 
      val error_r        = gen.cloneType(p.int_width,p.frac_width).asInput 
      val error_i        = gen.cloneType(p.int_width,p.frac_width).asInput 
      val cur_weight_r   = gen.cloneType(p.int_width,p.frac_width).asInput 
      val cur_weight_i   = gen.cloneType(p.int_width,p.frac_width).asInput 
      val new_weight_r   = gen.cloneType(p.int_width,p.frac_width).asOutput 
      val new_weight_i   = gen.cloneType(p.int_width,p.frac_width).asOutput 
    }
  override val io = new LMSIO(gen, p)

    val error_sign_r = Mux(io.error_r > double2T(0), double2T(1) , double2T(-1))
    val error_sign_i = Mux(io.error_i > double2T(0), double2T(1) , double2T(-1))

    val in_sign_r = Mux(io.signalIn_real > double2T(0), double2T(1) , double2T(-1))
    val in_sign_i = Mux(io.signalIn_imag > double2T(0), double2T(1) , double2T(-1))
    
   // val f_r_sign = double2T(p.mu, (p.int_width,p.frac_width)) * error_sign_r * in_sign_r 
   // val f_i_sign = double2T(p.mu, (p.int_width,p.frac_width)) * error_sign_i * in_sign_i 
 
    val f_r_sign = double2T(p.mu, (p.int_width,p.frac_width)) * error_sign_r * io.signalIn_real 
    val f_i_sign = double2T(p.mu, (p.int_width,p.frac_width)) * error_sign_i * io.signalIn_imag
    
    val f_r_lms = double2T(p.mu, (p.int_width,p.frac_width)) * io.error_r * io.signalIn_real
    val f_i_lms = double2T(p.mu, (p.int_width,p.frac_width)) * io.error_i * io.signalIn_imag

    //val f_r = Mux(UInt(p.algorithm) === UInt(0), f_r_lms, f_r_sign) //choose from lms or error sign
    //val f_i = Mux(UInt(p.algorithm) === UInt(0), f_i_lms, f_i_sign)
    val f_r = f_r_sign
    val f_i = f_i_sign
    when (UInt(p.algorithm)===UInt(0)){
        f_r := f_r_lms
	f_i := f_i_lms
    }.otherwise{
        f_r := f_r_sign
	f_i := f_i_sign
    }

    val stored_Weight_r_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_r + f_r
    val stored_Weight_i_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_i + f_i
   
    io.new_weight_r := (stored_Weight_r_long $ io.new_weight_r.getFracWidth).shorten(io.new_weight_r.getRange)
    io.new_weight_i := (stored_Weight_i_long $ io.new_weight_i.getFracWidth).shorten(io.new_weight_i.getRange)
}

class EQ[T <: DSPQnm[T]](gen : => T, p : CEParams) extends GenDSPModule (gen) {
    class EQIO [T <: DSPQnm[T]](gen : => T, p : CEParams) extends IOBundle {
    
      val signalIn_real  = gen.cloneType(p.int_width,p.frac_width).asInput 
      val signalIn_imag  = gen.cloneType(p.int_width,p.frac_width).asInput 
      val weight_r       = gen.cloneType(p.int_width,p.frac_width).asInput 
      val weight_i       = gen.cloneType(p.int_width,p.frac_width).asInput 
      val signalOut_real = gen.cloneType(p.int_width,p.frac_width).asOutput
      val signalOut_imag = gen.cloneType(p.int_width,p.frac_width).asOutput
    }
  override val io = new EQIO(gen, p) 
      val signalOut_real_long = io.weight_r * io.signalIn_real
      val signalOut_imag_long = io.weight_i * io.signalIn_imag
      val temp_real_O = signalOut_real_long $(io.signalOut_real.getFracWidth)
      val temp_imag_O = signalOut_imag_long $(io.signalOut_imag.getFracWidth)
      io.signalOut_real := temp_real_O.shorten(io.signalOut_real.getRange)
      io.signalOut_imag := temp_imag_O.shorten(io.signalOut_imag.getRange)
}

class CE[T <: DSPQnm[T]](gen : => T, p : CEParams) extends GenDSPModule (gen) {

    class CEIO [T <: DSPQnm[T]](gen : => T, p : CEParams) extends IOBundle {
    
      val signalIn_real  = gen.cloneType(p.int_width,p.frac_width).asInput 
      val signalIn_imag  = gen.cloneType(p.int_width,p.frac_width).asInput 
      val signalOut_real = gen.cloneType(p.int_width,p.frac_width).asOutput
      val signalOut_imag = gen.cloneType(p.int_width,p.frac_width).asOutput
    }

  override val io = new CEIO(gen, p) 
  //useful numbers
  val pt_number = (math.ceil(p.frame_size.toDouble/p.pt_position.toDouble)).toInt 
  val stored_Weight_r = Vec.fill(pt_number){RegInit(double2T(1.0, (p.int_width,p.frac_width)))}
  val stored_Weight_i = Vec.fill(pt_number){RegInit(double2T(1.0, (p.int_width,p.frac_width)))}

  val pt_value_r = double2T(p.pt_value_r, (p.int_width,p.frac_width))
  val pt_value_i = double2T(p.pt_value_i, (p.int_width,p.frac_width))

  val sigCount = RegInit(UInt(0,width = (math.ceil(math.log(p.frame_size)*4)).toInt))
  val PTCount =  RegInit(UInt(0,width = (math.ceil(math.log(pt_number)*4)).toInt))
  val sigPosition =  RegInit(UInt(0,width = (math.ceil(math.log(p.pt_position)*4)).toInt))  //Indicate the signal position in a ( PT DATA) block. so if sigPosition is equal to pt_position, it's a PT, other wise it's the position of the signal, the initial 1 should be assigned to 1 again after the first cycle
  val IsPT = Bool(true) 
  
  val ceeq = DSPModule(new EQ(gen,p))  //declare sub circuits  
  val celms = DSPModule(new LMS(gen,p)) //declare sub circuits   

  val cur_weight_r = stored_Weight_r(PTCount)
  val cur_weight_i = stored_Weight_i(PTCount)

  val error_r = pt_value_r - io.signalOut_real
  val error_i = pt_value_i - io.signalOut_imag
  //equalizer is always connected 
  ceeq.io.signalIn_real := io.signalIn_real
  ceeq.io.weight_r := (cur_weight_r $ ceeq.io.weight_r.getFracWidth).shorten(ceeq.io.weight_r.getRange)
  io.signalOut_real := ceeq.io.signalOut_real

  ceeq.io.signalIn_imag := io.signalIn_imag
  ceeq.io.weight_i := (cur_weight_i $ ceeq.io.weight_i.getFracWidth).shorten(ceeq.io.weight_i.getRange)
  io.signalOut_imag := ceeq.io.signalOut_imag
  //Connect lms all the time as well
  celms.io.error_r := (error_r $ celms.io.error_r.getFracWidth).shorten(celms.io.error_r.getRange)
  celms.io.signalIn_real := io.signalOut_real
  celms.io.cur_weight_r := (cur_weight_r $ celms.io.cur_weight_r.getFracWidth).shorten(celms.io.cur_weight_r.getRange)
  
  celms.io.error_i := (error_i $ celms.io.error_i.getFracWidth).shorten(celms.io.error_i.getRange)
  celms.io.signalIn_imag := io.signalOut_imag
  celms.io.cur_weight_i := (cur_weight_i $ celms.io.cur_weight_i.getFracWidth).shorten(celms.io.cur_weight_i.getRange)
  //output only pass back to the reg if it is a PT


  when (sigCount =/= UInt(p.frame_size)){
    sigCount := sigCount + UInt(1)
  }.otherwise{
    sigCount := UInt(0)
    PTCount := UInt(0)
  }
 
  //when (sigCount%UInt(p.pt_position) === UInt(1) ) //input is a PT
  when (UInt(sigPosition) === (UInt(p.pt_position)-UInt(1))  || (sigCount === UInt(0))){ //input is a PT
    IsPT := Bool(true)
    PTCount := PTCount + UInt(1)
    sigPosition := UInt(0)
   //update the weight here
    stored_Weight_r(PTCount) := (celms.io.new_weight_r $ stored_Weight_r(0).getFracWidth).shorten(stored_Weight_r(0).getRange)
    stored_Weight_i(PTCount) := (celms.io.new_weight_i $ stored_Weight_i(0).getFracWidth).shorten(stored_Weight_i(0).getRange)
   }.otherwise {
    IsPT := Bool(false)
    sigPosition := sigPosition + UInt(1)
   }
}
//        when (UInt(p.interp) === UInt(0)){
//            val tmp_weight_r = stored_Weight_r(PTCount)
//            val tmp_weight_i = stored_Weight_i(PTCount)
//
//        }.otherwise {
//            val next_w = sigPosition/UInt(p.pt_position)
//            val current_w = UInt(1) - next_w
//	    println (current_w)
//            val tmp_weight_r = stored_Weight_r(PTCount)*current_w
	     // +stored_Weight_r(PTCount + UInt(1)) * next_w
//            val tmp_weight_i = stored_Weight_i(PTCount)

//          val signalOut_real_long = tmp_weight_r * io.signalIn_real
//            val signalOut_imag_long = tmp_weight_i * io.signalIn_imag
//     //     println (signalOut_real_long)
//     //       val temp_real_O = signalOut_real_long $(p.frac_width)
//            val temp_imag_O = signalOut_imag_long $(io.signalOut_imag.getFracWidth)
       //     //io.signalOut_real := temp_real_O.shorten(io.signalOut_real.getRange)
//            io.signalOut_imag := temp_imag_O.shorten(io.signalOut_imag.getRange)
//        println (test)
//        println (test.getFracWidth)
//        println (test.getIntWidth)
//        println (io.signalOut_real.getFracWidth)
//        println (io.signalOut_real.getIntWidth)
        //io.signalOut_real := signalOut_real_long.shorten(io.signalOut_real.getRange)
        //io.signalOut_imag := signalOut_imag_long.shorten(io.signalOut_imag.getRange)
        //io.signalOut_real := signalOut_real_long.shorten(p.frac_width)
        //io.signalOut_imag := signalOut_imag_long.shorten(p.frac_width)
