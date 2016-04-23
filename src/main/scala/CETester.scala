package CE
import ChiselDSP._
import Chisel.{Complex => _, _}
import scala.io.Source
import java.io._


// WARNING: MULTIPLE CLOCK DOMAINS NOT SUPPORTED. POKED LOGIC MUST BE CLOCKED! (For VerilogTB to function)

/** Module tester that allows switching between fixed and floating point testing */
class CETests[T <: CE[_ <: DSPQnm[_]]](c: T) extends DSPTester(c) {

val r_test_input = Source.fromFile("dirty_r.txt").getLines.toArray
val i_test_input = Source.fromFile("dirty_i.txt").getLines.toArray

val r_writer = new PrintWriter(new File("r_output.txt"))
val i_writer = new PrintWriter(new File("i_output.txt"))

peek (c.sigCount)
step(1)
for (i <- 0 until i_test_input.length){
          poke(c.io.signalIn_real, r_test_input(i).toDouble)
          poke(c.io.signalIn_imag, i_test_input(i).toDouble)
          peek (c.sigCount)
          peek (c.PTCount)
          peek (c.sigPosition)
          peek (c.cur_weight_r)
          peek (c.error_r)
          peek (c.celms.io.new_weight_r)
	  var r_output:Double = peek(c.io.signalOut_real)
	  var i_output:Double = peek(c.io.signalOut_imag)
//	  r_writer.write(r_output.toString +"\n")
//	  i_writer.write(i_output.toString +"\n")
	  step(1)
	  }
//r_writer.close()
//i_writer.close()

//poke(c.io.signalIn_real, 2.0)
//poke(c.io.signalIn_imag, 2.0)
//expect(c.io.signalOut_real, 1.8)
//expect(c.io.signalOut_imag, 1.8)
//step (1)
//poke(c.io.signalIn_real, 2.0)
//poke(c.io.signalIn_imag, 2.0)
//expect(c.io.signalOut_real, 1.8)
//expect(c.io.signalOut_imag, 1.8)
//step (1)
//poke(c.io.signalIn_real, 2.0)
//poke(c.io.signalIn_imag, 2.0)
//expect(c.io.signalOut_real, 1.8)
//expect(c.io.signalOut_imag, 1.8)
//step (1)
}
