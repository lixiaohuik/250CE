package CE
import ChiselDSP._
import Chisel.{Complex => _, _}

// WARNING: MULTIPLE CLOCK DOMAINS NOT SUPPORTED. POKED LOGIC MUST BE CLOCKED! (For VerilogTB to function)

/** Module tester that allows switching between fixed and floating point testing */
class CETests[T <: CE[_ <: DSPQnm[_]]](c: T) extends DSPTester(c) {

}