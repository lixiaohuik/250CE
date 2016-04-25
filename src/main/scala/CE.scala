package CE
//try linear and still testing

// ------- Imports START -- DO NOT MODIFY BELOW
import Chisel.{Complex => _, Mux => _, Reg => _, RegNext => _, RegInit => _, Pipe => _, Mem => _, SeqMem => _,
               Module => _, ModuleOverride => _, when => _, switch => _, is => _, unless => _, Round => _,  _}
import ChiselDSP._
// ------- Imports END -- OK TO MODIFY BELOW
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.ListBuffer

/** Module that supports both fixed and floating point testing */
// assum have the pilot tone first?

case class CEParams (
   interp:      Int     = 0,                   // 0: step , 1 : linear    
   algorithm:   Int     = 0,                   // 0: lms, 1: sign
   mu:		Double	= 0.05,                 //step size
   alpha:	Double	= 1.0,                 //coefficient of older weight
   pt_position: Int	= 8,                   // # of signals between PT + 1 (pitch?)
   frame_size: 	Int 	= 16,                   // # of sub-carriers
   min_value:	Double  = -127.0,			// DSPFixed uses min value to determine bit width rather than actual bit width,
   max_value: 	Double 	= 127.0,				// DSPFixed uses max value to determine bit width rather than actual bit width,
   frac_width:	Int	= 20,				// DSPFixed has extra argument for fraction width,
   int_width:	Int	= 3,				// DSPFixed has extra argument for fraction width,
   pipeline:	Int	= 0,		       // 0 for no pipeline, 1 for 1 pipeline

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

  if (p.pipeline == 0 || p.pipeline == 1) {
    if (p.algorithm == 0){//lms
        val f_r_lms = double2T(p.mu, (p.int_width,p.frac_width)) * io.error_r * io.signalIn_real
        val f_i_lms = double2T(p.mu, (p.int_width,p.frac_width)) * io.error_i * io.signalIn_imag

        val stored_Weight_r_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_r + f_r_lms
        val stored_Weight_i_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_i + f_i_lms
        io.new_weight_r := (stored_Weight_r_long $ io.new_weight_r.getFracWidth).shorten(io.new_weight_r.getRange)
        io.new_weight_i := (stored_Weight_i_long $ io.new_weight_i.getFracWidth).shorten(io.new_weight_i.getRange)
      }
      else{//error sign
        when(io.error_r > double2T(0)){
	  val f_r_sign = double2T(p.mu, (p.int_width,p.frac_width)) * io.signalIn_real 
          val stored_Weight_r_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_r + f_r_sign
        io.new_weight_r := (stored_Weight_r_long $ io.new_weight_r.getFracWidth).shorten(io.new_weight_r.getRange)
	}.otherwise{
	  val f_r_sign = double2T(p.mu, (p.int_width,p.frac_width)) * io.signalIn_real 
          val stored_Weight_r_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_r - f_r_sign
        io.new_weight_r := (stored_Weight_r_long $ io.new_weight_r.getFracWidth).shorten(io.new_weight_r.getRange)
	}
        when(io.error_i > double2T(0)){
	  val f_i_sign = double2T(p.mu, (p.int_width,p.frac_width)) * io.signalIn_imag
          val stored_Weight_i_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_i + f_i_sign
        io.new_weight_i := (stored_Weight_i_long $ io.new_weight_i.getFracWidth).shorten(io.new_weight_i.getRange)
	}.otherwise{
	  val f_i_sign = double2T(p.mu, (p.int_width,p.frac_width)) * io.signalIn_imag 
          val stored_Weight_i_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_i - f_i_sign
        io.new_weight_i := (stored_Weight_i_long $ io.new_weight_i.getFracWidth).shorten(io.new_weight_i.getRange)
	}
      }
    } else if (p.pipeline == 2) {
//pipeline
    if (p.algorithm == 0){//lms
        val f_r_lms_reg = RegInit(double2T(1.0, (p.int_width,p.frac_width)))
        val f_i_lms_reg = RegInit(double2T(1.0, (p.int_width,p.frac_width)))
        val f_r_lms = double2T(p.mu, (p.int_width,p.frac_width)) * io.error_r * io.signalIn_real
        val f_i_lms = double2T(p.mu, (p.int_width,p.frac_width)) * io.error_i * io.signalIn_imag
        when(Bool(true)){
          f_r_lms_reg := (f_r_lms $ f_r_lms_reg.getFracWidth)
          f_i_lms_reg := (f_i_lms $ f_i_lms_reg.getFracWidth)
        }

        val stored_Weight_r_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_r + f_r_lms_reg
        val stored_Weight_i_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_i + f_i_lms_reg
        io.new_weight_r := (stored_Weight_r_long $ io.new_weight_r.getFracWidth).shorten(io.new_weight_r.getRange)
        io.new_weight_i := (stored_Weight_i_long $ io.new_weight_i.getFracWidth).shorten(io.new_weight_i.getRange)
      }
      else{//error sign
        val f_r_sign_reg = RegInit(double2T(1.0, (p.int_width,p.frac_width)))
        val f_i_sign_reg = RegInit(double2T(1.0, (p.int_width,p.frac_width)))
        
	when(io.error_r > double2T(0)){
	  val f_r_sign = double2T(p.mu, (p.int_width,p.frac_width)) * io.signalIn_real 
          f_r_sign_reg := (f_r_sign $ f_r_sign_reg.getFracWidth)
          val stored_Weight_r_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_r + f_r_sign_reg
        io.new_weight_r := (stored_Weight_r_long $ io.new_weight_r.getFracWidth).shorten(io.new_weight_r.getRange)
	}.otherwise{
	  val f_r_sign = double2T(p.mu, (p.int_width,p.frac_width)) * io.signalIn_real 
          f_r_sign_reg := (f_r_sign $ f_r_sign_reg.getFracWidth)
          val stored_Weight_r_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_r - f_r_sign_reg
        io.new_weight_r := (stored_Weight_r_long $ io.new_weight_r.getFracWidth).shorten(io.new_weight_r.getRange)
	}
        when(io.error_i > double2T(0)){
	  val f_i_sign = double2T(p.mu, (p.int_width,p.frac_width)) * io.signalIn_imag
          f_i_sign_reg := (f_i_sign $ f_i_sign_reg.getFracWidth)
          val stored_Weight_i_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_i + f_i_sign_reg
        io.new_weight_i := (stored_Weight_i_long $ io.new_weight_i.getFracWidth).shorten(io.new_weight_i.getRange)
	}.otherwise{
	  val f_i_sign = double2T(p.mu, (p.int_width,p.frac_width)) * io.signalIn_imag 
          f_i_sign_reg := (f_i_sign $ f_i_sign_reg.getFracWidth)
          val stored_Weight_i_long = double2T(p.alpha,(p.int_width, p.frac_width)) * io.cur_weight_i - f_i_sign_reg
        io.new_weight_i := (stored_Weight_i_long $ io.new_weight_i.getFracWidth).shorten(io.new_weight_i.getRange)
	}
      }
  }
    
}

class EQ[T <: DSPQnm[T]](gen : => T, p : CEParams) extends GenDSPModule (gen) {
    class EQIO [T <: DSPQnm[T]](gen : => T, p : CEParams) extends IOBundle {
    
      val signalIn_real  = gen.cloneType(p.int_width,p.frac_width).asInput 
      val signalIn_imag  = gen.cloneType(p.int_width,p.frac_width).asInput 
      val weight_r       = gen.cloneType(p.int_width,p.frac_width).asInput 
      val weight_i       = gen.cloneType(p.int_width,p.frac_width).asInput 
      val signalOut_real = gen.cloneType(p.int_width,p.frac_width).asOutput
      val signalOut_imag = gen.cloneType(p.int_width,p.frac_width).asOutput
      val weight_r_2       = gen.cloneType(p.int_width,p.frac_width).asInput   //needed for linear interpolation
      val weight_i_2       = gen.cloneType(p.int_width,p.frac_width).asInput 
      val sigPosition      = gen.cloneType(3,1).asInput 
    }
  override val io = new EQIO(gen, p) 
// create LUT look up table for fractions used for linear interpolation
      
      if (p.interp == 1){//linear
      val frac = Vector(1.00,0.5,0.3333,0.25,0.2,0.16667,0.14286,0.125,0.11111,0.1)

      val nex_w_frac = double2T(frac(p.pt_position)) * (io.sigPosition-double2T(1.0))
      val cur_w_frac = double2T(1.0) - nex_w_frac
      val linear_w_r = cur_w_frac * io.weight_r + nex_w_frac *io.weight_r_2
      val linear_w_i = cur_w_frac * io.weight_i + nex_w_frac *io.weight_i_2
      val signalOut_real_long = linear_w_r * io.signalIn_real
      val signalOut_imag_long = linear_w_i * io.signalIn_imag
      io.signalOut_real := (signalOut_real_long $(io.signalOut_real.getFracWidth)).shorten(io.signalOut_real.getRange)
      io.signalOut_imag := (signalOut_imag_long $(io.signalOut_imag.getFracWidth)).shorten(io.signalOut_imag.getRange)
      }
      else{
      val signalOut_real_long = io.weight_r * io.signalIn_real
      val signalOut_imag_long = io.weight_i * io.signalIn_imag
      io.signalOut_real := (signalOut_real_long $(io.signalOut_real.getFracWidth)).shorten(io.signalOut_real.getRange)
      io.signalOut_imag := (signalOut_imag_long $(io.signalOut_imag.getFracWidth)).shorten(io.signalOut_imag.getRange)
      }
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
  val pt_number = (math.ceil(p.frame_size.toDouble/p.pt_position.toDouble)+ 1).toInt 
  val stored_Weight_r = Vec.fill(pt_number){RegInit(double2T(1.0, (p.int_width,p.frac_width)))}
  val stored_Weight_i = Vec.fill(pt_number){RegInit(double2T(1.0, (p.int_width,p.frac_width)))}

  val pt_value_r = double2T(p.pt_value_r, (p.int_width,p.frac_width))
  val pt_value_i = double2T(p.pt_value_i, (p.int_width,p.frac_width))

  val sigCount = RegInit(UInt(0,width = (math.ceil(math.log(p.frame_size+1)*4)).toInt))
  val PTCount =  RegInit(UInt(1,width = (math.ceil(math.log(pt_number+1)*4)).toInt))
  val sigPosition =  RegInit(UInt(0,width = (math.ceil(math.log(p.pt_position+1)*4)).toInt))  //Indicate the signal position in a ( PT DATA) block
  val sigPosition_dbl =  RegInit(double2T(0, (p.int_width,p.frac_width)))  //Same as sigPosition
  val IsPT = RegInit(Bool(true)) 
  
  val ceeq = DSPModule(new EQ(gen,p))  //declare sub circuits  
  val celms = DSPModule(new LMS(gen,p)) //declare sub circuits   

  val cur_weight_r = stored_Weight_r(PTCount)
  val cur_weight_i = stored_Weight_i(PTCount)
//for linear interpolation
  val sec_weight_r = stored_Weight_r(PTCount+UInt(1))
  val sec_weight_i = stored_Weight_i(PTCount+UInt(1))

  // pipeline registers
  val signalIn_real_reg = RegInit(double2T(1.0, (p.int_width,p.frac_width)))
  val signalIn_imag_reg = RegInit(double2T(1.0, (p.int_width,p.frac_width)))
  val prev_weight_real_reg = RegInit(double2T(1.0, (p.int_width,p.frac_width)))
  val prev_weight_imag_reg = RegInit(double2T(1.0, (p.int_width,p.frac_width)))
  val eq_out_real_reg = RegInit(double2T(1.0, (p.int_width,p.frac_width)))
  val eq_out_imag_reg = RegInit(double2T(1.0, (p.int_width,p.frac_width)))
  val PT_reg = RegInit(UInt(1,width = (math.ceil(math.log(pt_number+1)*4)).toInt))
  val sig_pos_reg = RegInit(UInt(0,width = (math.ceil(math.log(p.pt_position+1)*4)).toInt))

  // second set of pipeline registers  
  val PT_reg2 = RegInit(UInt(1,width = (math.ceil(math.log(pt_number+1)*4)).toInt))
  val sig_pos_reg2 = RegInit(UInt(0,width = (math.ceil(math.log(p.pt_position+1)*4)).toInt))

  // if pipelining
  if (p.pipeline > 0){
    when(Bool(true)){
      signalIn_real_reg := io.signalIn_real
      signalIn_imag_reg := io.signalIn_imag
      prev_weight_real_reg := cur_weight_r
      prev_weight_imag_reg := cur_weight_i
      eq_out_real_reg := ceeq.io.signalOut_real
      eq_out_imag_reg := ceeq.io.signalOut_imag
      PT_reg := PTCount  
      sig_pos_reg := sigPosition
    }
  }

  if (p.pipeline == 2) {
    when(Bool(true)){  
      PT_reg2 := PT_reg
      sig_pos_reg2 := sig_pos_reg
    }
  }


  val error_r = pt_value_r - io.signalOut_real
  val error_i = pt_value_i - io.signalOut_imag
  //equalizer is always connected 
  ceeq.io.signalIn_real := io.signalIn_real
  ceeq.io.weight_r := (cur_weight_r $ ceeq.io.weight_r.getFracWidth).shorten(ceeq.io.weight_r.getRange)
  ceeq.io.weight_r_2 := (sec_weight_r $ ceeq.io.weight_r_2.getFracWidth).shorten(ceeq.io.weight_r_2.getRange)

  ceeq.io.signalIn_imag := io.signalIn_imag
  ceeq.io.weight_i := (cur_weight_i $ ceeq.io.weight_i.getFracWidth).shorten(ceeq.io.weight_i.getRange)
  ceeq.io.weight_i_2 := (sec_weight_i $ ceeq.io.weight_i_2.getFracWidth).shorten(ceeq.io.weight_i_2.getRange)
  
  ceeq.io.sigPosition := (sigPosition_dbl $ ceeq.io.sigPosition.getFracWidth).shorten(ceeq.io.sigPosition.getRange)//no double2T?

  if (p.pipeline == 0) {
    io.signalOut_real := ceeq.io.signalOut_real
    io.signalOut_imag := ceeq.io.signalOut_imag
  } else {
    io.signalOut_real := eq_out_real_reg
    io.signalOut_imag := eq_out_imag_reg
  }

  //Connect lms all the time as well
  celms.io.error_r := (error_r $ celms.io.error_r.getFracWidth).shorten(celms.io.error_r.getRange)
  celms.io.error_i := (error_i $ celms.io.error_i.getFracWidth).shorten(celms.io.error_i.getRange)
  if (p.pipeline == 0) {
    celms.io.signalIn_real := io.signalIn_real
    celms.io.cur_weight_r := (cur_weight_r $ celms.io.cur_weight_r.getFracWidth).shorten(celms.io.cur_weight_r.getRange)
  
    celms.io.signalIn_imag := io.signalIn_imag
    celms.io.cur_weight_i := (cur_weight_i $ celms.io.cur_weight_i.getFracWidth).shorten(celms.io.cur_weight_i.getRange)
  } else {
    celms.io.signalIn_real := signalIn_real_reg
    celms.io.cur_weight_r := prev_weight_real_reg 
  
    celms.io.signalIn_imag := signalIn_imag_reg
    celms.io.cur_weight_i := prev_weight_real_reg
  }
  
debug (sigCount)
debug (PTCount)
debug (sigPosition)
debug (error_r)

  when (sigCount === UInt(p.frame_size)) {
    sigCount := UInt(1)
  }.otherwise {
    sigCount := sigCount + UInt(1)
  }

  when (sigPosition === UInt(p.pt_position)) {
    sigPosition := UInt(1)
    sigPosition_dbl := double2T(1, (p.int_width,p.frac_width))
  }.otherwise {
    sigPosition := sigPosition + UInt(1)
    sigPosition_dbl := ((sigPosition_dbl + double2T(1.0)) $ p.frac_width).shorten(sigPosition_dbl.getRange)
  }

  when (sigCount === UInt(p.frame_size)) {
    PTCount := UInt(1)
  }.elsewhen (sigPosition === UInt(p.pt_position)) {
    PTCount := PTCount + UInt(1)
  }
  
  if (p.pipeline == 0) {
    when (sigPosition === UInt(1)) {
      stored_Weight_r(PTCount) := (celms.io.new_weight_r $ stored_Weight_r(0).getFracWidth).shorten(stored_Weight_r(0).getRange)
      stored_Weight_i(PTCount) := (celms.io.new_weight_i $ stored_Weight_i(0).getFracWidth).shorten(stored_Weight_i(0).getRange)
    }
  } else if (p.pipeline == 1){
    when (sig_pos_reg === UInt(1)) {
      stored_Weight_r(PT_reg) := (celms.io.new_weight_r $ stored_Weight_r(0).getFracWidth).shorten(stored_Weight_r(0).getRange)
      stored_Weight_i(PT_reg) := (celms.io.new_weight_i $ stored_Weight_i(0).getFracWidth).shorten(stored_Weight_i(0).getRange)
    }
  } else if (p.pipeline == 2){
    when (sig_pos_reg2 === UInt(1)) {
      stored_Weight_r(PT_reg2) := (celms.io.new_weight_r $ stored_Weight_r(0).getFracWidth).shorten(stored_Weight_r(0).getRange)
      stored_Weight_i(PT_reg2) := (celms.io.new_weight_i $ stored_Weight_i(0).getFracWidth).shorten(stored_Weight_i(0).getRange)
    }
  }

}
