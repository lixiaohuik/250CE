package CE
import ChiselDSP._
import Chisel.{Complex => _, _}
import scala.io.Source
import java.io._


// WARNING: MULTIPLE CLOCK DOMAINS NOT SUPPORTED. POKED LOGIC MUST BE CLOCKED! (For VerilogTB to function)

/** Module tester that allows switching between fixed and floating point testing */
class CETests[T <: CE[_ <: DSPQnm[_]]](c: T) extends DSPTester(c) {

//val r_test_input = Source.fromFile("dirty_r.txt").getLines.toArray
//val i_test_input = Source.fromFile("dirty_i.txt").getLines.toArray
val r_test_input = Source.fromFile("Linear_dirty_r.txt").getLines.toArray
val i_test_input = Source.fromFile("Linear_dirty_i.txt").getLines.toArray

val r_writer = new PrintWriter(new File("r_output.txt"))
val i_writer = new PrintWriter(new File("i_output.txt"))

peek (c.sigCount)
step(1)
for (i <- 0 until r_test_input.length){
//for (i <- 0 until 20){
          poke(c.io.signalIn_real, r_test_input(i).toDouble)
          poke(c.io.signalIn_imag, i_test_input(i).toDouble)
          peek (c.sigCount)
          peek (c.PTCount)
          peek (c.sigPosition)
          peek (c.cur_weight_r)
          //peek (c.PT_reg2)
          //peek (c.sig_pos_reg2)
          //peek (c.prev_weight_real_reg)
          peek (c.error_r)
          peek (c.celms.io.new_weight_r)
	  var r_output:Double = peek(c.io.signalOut_real)
	  var i_output:Double = peek(c.io.signalOut_imag)
	  //var r_output:Double = peek(c.io.fpga_signalOut_real)
	  //var i_output:Double = peek(c.io.fpga_signalOut_imag)
	  r_writer.write(r_output.toString +"\n")
	  i_writer.write(i_output.toString +"\n")
	  step(1)
	  }
r_writer.close()
i_writer.close()
}
