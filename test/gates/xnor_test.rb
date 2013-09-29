require './test/test_helper'
require './lib/gates/xnor'

class XnorTest < GateTest
  def gate
    @gate ||= Gates::Xnor.new
  end

  def test_it_is_high_when_inputs_are_low
    gate.input_a = LOW
    gate.input_b = LOW
    assert_high gate.output
  end

  def test_it_is_low_when_input_a_is_high_and_b_is_low
    gate.input_a = HIGH
    gate.input_b = LOW
    assert_low gate.output
  end

  def test_it_is_low_when_input_a_is_low_and_b_is_high
    gate.input_a = LOW
    gate.input_b = HIGH
    assert_low gate.output
  end

  def test_it_is_high_when_both_inputs_are_high
    gate.input_a = HIGH
    gate.input_b = HIGH
    assert_high gate.output
  end

  def test_it_accepts_pin_status_on_initialize
    g2 = Gates::Xnor.new(input_a: HIGH, input_b: LOW)
    assert_high g2.input_a
    assert_low g2.input_b
    assert_low g2.output
  end
end
