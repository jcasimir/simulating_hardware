require './test/test_helper'
require './lib/mux/one_bit_multiplexer'

class OneBitMultiplexer < GateTest
  def mux
    @mux ||= Mux::OneBitMultiplexer.new
  end

  def test_all_low_inputs_low_output
    mux.input_a = LOW
    mux.input_b = LOW
    mux.control = LOW
    assert_low mux.output
  end

  def test_high_a_and_low_control_outputs_high
    skip
    mux.input_a = HIGH
    mux.input_b = LOW
    mux.control = LOW
    assert_high mux.output
  end

  def test_high_b_and_low_control_outputs_low
    skip
    mux.input_a = LOW
    mux.input_b = HIGH
    mux.control = LOW
    assert_low mux.output
  end

  def test_low_b_and_high_control_outputs_low
    mux.input_a = LOW
    mux.input_b = LOW
    mux.control = HIGH
    assert_low mux.output
  end

  def test_high_b_and_high_control_outputs_high
    mux.input_a = LOW
    mux.input_b = HIGH
    mux.control = HIGH
    assert_high mux.output
  end
end
