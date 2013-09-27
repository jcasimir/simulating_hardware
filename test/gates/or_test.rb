require './test/test_helper'
require './lib/gates/or'

class OrTest < GateTest
  def gate
    @gate ||= Gates::Or.new
  end

  def test_it_works_through_initialize
    assert_low Gates::Or.new(input_a: LOW, input_b: LOW).output
    assert_high Gates::Or.new(input_a: HIGH, input_b: LOW).output
    assert_high Gates::Or.new(input_a: LOW, input_b: HIGH).output
    assert_high Gates::Or.new(input_a: HIGH, input_b: HIGH).output
  end

  def test_it_outputs_low_when_inputs_are_low
    gate.input_a = LOW
    gate.input_b = LOW
    assert_low gate.output
  end

  def test_it_outputs_high_when_input_a_is_high_and_b_is_low
    gate.input_a = HIGH
    gate.input_b = LOW
    assert_high gate.output
  end

  def test_it_outputs_high_when_input_a_is_low_and_b_is_high
    gate.input_a = LOW
    gate.input_b = HIGH
    assert_high gate.output
  end

  def test_it_outputs_high_when_both_inputs_are_high
    gate.input_a = HIGH
    gate.input_b = HIGH
    assert_high gate.output
  end

end
