package CE

// ------- Imports START -- DO NOT MODIFY BELOW
import Chisel.{Complex => _, Mux => _, Reg => _, RegNext => _, RegInit => _, Pipe => _, Mem => _, SeqMem => _,
               Module => _, ModuleOverride => _, when => _, switch => _, is => _, unless => _, Round => _,  _}
import ChiselDSP._
// ------- Imports END -- OK TO MODIFY BELOW

/** Module that supports both fixed and floating point testing */
// assum have the pilot tone first?

case class CEParams (
    maxmu: Double=1.0
    pt_position: DSPUInt=3
    frame_size: DSPUInt=20
    data_size: DSPUInt=2
    pt_value: DSPUInt=2
    width: DSPUInt=5
)

class CE[T <: DSPQnm[T]](gen : => T) extends GenDSPModule (gen) {

class CEIO [T <: DSPQnm[T]](gen : => T) extends IOBundle {
//input signal  
  val signalIn = Complex(gen).asInput


}
//get the pilot tone with the position
  val sigCount = DSPUInt(0, frame_size)
  val PTCount = DSPUInt(0, frame_size)
  val IsPT = DSPBool(false)
  val weight = Vec.fill(p.width) { Reg(init= DSPUInt(0,width = p.data_size)) }
  val pt = Vec.fill(6) { Reg(DSPUInt()) }
  if (sigCount != frame_size ){
      sigCount := sigCount + DSPUInt(1)
      if (sigCount%p.pt_position == DSPUInt(1) ){
      IsPT := DSPBool(true)
      PTcount := PTcount + DSPUInt(1)
      //do calculation here
      }.otherwise{
      IsPT := DSPBool(false)
      }
  }.otherwise{
      sigCount := DSPUInt(0)
  }
// if it is pilot, save the value

  val pt = Vec.fill(6) { Reg(DSPUInt()) }
  when (IsPT) {
    pt (0) := io.signalIn.real
    pt (1) := pt (0)
    pt (2) := pt (1)
  
  }
// repeat for imaginary/real part
//create shift Reg group to save Inputs for width of time (a param for max width)
//input length is 'width' long, so it needs padding at first few cycles 
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

