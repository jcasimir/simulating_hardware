require './test/test_helper'
require './lib/gates/xor'

class XorTest < GateTest
  def gate
    @gate ||= Gates::Xor.new
  end

  def test_it_is_low_when_inputs_are_low
    gate.input_a = LOW
    gate.input_b = LOW
    assert_low gate.output
  end

  def test_it_is_high_when_input_a_is_high_and_b_is_low
    gate.input_a = HIGH
    gate.input_b = LOW
    assert_high gate.output
  end

  def test_it_is_high_when_input_a_is_low_and_b_is_high
    gate.input_a = LOW
    gate.input_b = HIGH
    assert_high gate.output
  end

  def test_it_is_low_when_both_inputs_are_high
    gate.input_a = HIGH
    gate.input_b = HIGH
    assert_low gate.output
  end
end
