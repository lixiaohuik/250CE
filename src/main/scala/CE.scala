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

//create shift Reg group to save Inputs for width of time (a param for max width)
// width is how many data/co-eff used to determine , n is the dat length
class ShiftReg (width:Int, n:Int) extends Module {
  val io = new Bundle {
    val ins = Vec.fill(width){UInt(INPUT,n)}
    val load = Bool(INPUT)
    val shift = Bool(INPUT)
    val out = Vec.fill(width){UInt(OUTPUT,n)}
  }
  val delays = Vec.fill(width){ Reg(UInt()) }
  when (io.load) {
    for (i <- 0 until width){
      delays(i) := io.ins(i)
    }.elsewhen (io.shift) {
      delays(0) := io.ins(0)
      for (i <- 1 until width){
        delays(i) := delays(i-1)
      }
    }
  }
  io.out := delays
}
// the output is the whole vec, can be used to store the weight as well
// create several vec to store: original data, original PT, current weight (all length:width)

// creat reg to save the weight for each PT
class SaveReg (width:Int, n:Int) extends Module {
  val io = new Bundle {
    val ins = Vec.fill(width){UInt(INPUT,n)}
    val load = Bool(INPUT)
    val out = Vec.fill(width){UInt(OUTPUT,n)}
  }
  val stored = Vec.fill(width){ Reg(UInt()) }
  when (io.load) {
      stored := io.ins
      }
  io.out := stored
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
  val  stored_In= (0 until params.frame_size).map(i => Module(new ShiftReg(width = params.width, n = params.data_size)))
  val  stored_Weight= (0 until pt_number).map(i => Module(new SaveReg(width = params.width, n = params.data_size)))
  val tmp_in = Vec.fill(params.width){ Reg(UInt()) }
  val tmp_weight = Vec.fill(params.width){ Reg(UInt()) }

//determine whether is pilot tone using the position comb type
  val sigCount = DSPUInt(0, frame_size)
  val PTCount = DSPUInt(0, frame_size)
  val IsPT = DSPBool(false) //no need here, but needed for other PT position
  if (sigCount !== frame_size ){
      sigCount := sigCount + DSPUInt(1)
      stored_In(sigCount).io.ins(0) := signalIn.real.toInt  // no need toInt?
      stored_In(sigCount).io.shift := DSPBool (true)  // store input to the shiftreg
      if (sigCount%p.pt_position == DSPUInt(1) ){ //input is a PT
      IsPT := DSPBool(true)
      PTcount := PTcount + DSPUInt(1)
      //do calculation here
      tmp_in := stored_In(sigCount)
      tmp_weight := stored_Weight(PTCount)
      val dot_product := Reg(init=DSPUInt(0,width = params.data_size)) //need to truncate to data_size?
      for (i <- 0 until params.width){
        dot_product := dot_product + tmp_in(i) * tmp_weight(i) // get the dot product using weight and input
      } 
      signalOut_real := dot_product //if the input is PT assign the dot product to output and update weight
      val error = params.pt_value - dot_product
      val f = Vec.fill(params.width){ Reg(UInt()) }
      f = mu * error * tmp_in
      store_Weight(PTCount) := alpha * tmp_weight + f //update whole vector?
      }.otherwise{
      IsPT := DSPBool(false)
      tmp_in := stored_In(sigCount)
      tmp_weight := stored_Weight(PTCount)
      val dot_product := Reg(init=DSPUInt(0,width = params.data_size)) //need to truncate to data_size?
      for (i <- 0 until params.width){
        dot_product := dot_product + tmp_in(i) * tmp_weight(i) // get the dot product using weight and input
      } 
      signalOut_real := dot_product //if the input is not PT, assign the dot product to output
      }
  }.otherwise{
      sigCount := DSPUInt(0) //reset the counter for a new frame
      PTCount := DSPUInt(0)
      // same thing 
      stored_In(sigCount).io.ins(0) := signalIn.real.toInt  // no need toInt?
      stored_In(sigCount).io.shift := DSPBool (true)  // store input to the shiftreg
      if (sigCount%p.pt_position == DSPUInt(1) ){
      IsPT := DSPBool(true)
      PTcount := PTcount + DSPUInt(1)
      //do calculation here
      tmp_in := stored_In(sigCount)
      tmp_weight := stored_Weight(PTCount)
      val dot_product := Reg(init=DSPUInt(0,width = params.data_size)) //need to truncate to data_size?
      for (i <- 0 until params.width){
        dot_product := dot_product + tmp_in(i) * tmp_weight(i) // get the dot product using weight and input
      } 
      signalOut_real := dot_product //if the input is PT assign the dot product to output and update weight
      val error = params.pt_value - dot_product
      val f = Vec.fill(params.width){ Reg(UInt()) }
      f = mu * error * tmp_in
      store_Weight(PTCount) := alpha * tmp_weight + f //update whole vector?
      }.otherwise{
      IsPT := DSPBool(false)
      tmp_in := stored_In(sigCount)
      tmp_weight := stored_Weight(PTCount)
      val dot_product := Reg(init=DSPUInt(0,width = params.data_size)) //need to truncate to data_size?
      for (i <- 0 until params.width){
        dot_product := dot_product + tmp_in(i) * tmp_weight(i) // get the dot product using weight and input
      } 
      signalOut_real := dot_product //if the input is not PT, assign the dot product to output
      }
    }


}

}
