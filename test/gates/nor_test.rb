require './test/test_helper'
require './lib/gates/nor_gate'

class NorGateTest < GateTest
  def gate
    @gate ||= NorGate.new
  end

  def test_it_outputs_true_when_inputs_are_low
    gate.input_a = LOW
    gate.input_b = LOW
    assert_high gate.output
  end

  def test_it_outputs_false_when_input_a_is_high_and_b_is_low
    gate.input_a = HIGH
    gate.input_b = LOW
    assert_low gate.output
  end

  def test_it_outputs_false_when_input_a_is_low_and_b_is_high
    gate.input_a = LOW
    gate.input_b = HIGH
    assert_low gate.output
  end

  def test_it_outputs_false_when_both_inputs_are_high
    gate.input_a = HIGH
    gate.input_b = HIGH
    assert_low gate.output
  end

end