require './test/test_helper'
require './lib/mux/one_bit_demultiplexer'

class OneBitDemultiplexer < GateTest
  def mux
    @mux ||= Mux::OneBitDemultiplexer.new
  end

  def test_all_low_inputs_low_output
    mux.input = LOW
    mux.control = LOW
    assert_low mux.output_a
    assert_low mux.output_b
  end

  def test_high_input_and_low_control_outputs_high_on_a
    mux.input = HIGH
    mux.control = LOW
    assert_high mux.output_a
    assert_low mux.output_b
  end

  def test_high_input_and_high_control_outputs_high_on_b
    mux.input = HIGH
    mux.control = HIGH
    assert_low mux.output_a
    assert_high mux.output_b
  end
end
