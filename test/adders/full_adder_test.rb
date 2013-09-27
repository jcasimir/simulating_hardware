require './test/test_helper'
require './lib/adders/full'

class FullAdderTest < GateTest
  def adder
    @adder ||= Adders::Full.new
  end

  def test_sum_is_low_when_all_inputs_are_low
    adder.input_a = LOW
    adder.input_b = LOW
    adder.carry_in = LOW
    assert_low adder.sum
    assert_low adder.carry_out
  end

  def test_only_sum_is_high_when_only_input_a_is_high
    adder.input_a = HIGH
    adder.input_b = LOW
    adder.carry_in = LOW
    assert_high adder.sum
    assert_low adder.carry_out
  end

  def test_only_sum_is_high_when_only_input_b_is_high
    adder.input_a = LOW
    adder.input_b = HIGH
    adder.carry_in = LOW
    assert_high adder.sum
    assert_low adder.carry_out
  end

  def test_only_sum_is_high_when_only_carry_in_is_high
    adder.input_a = LOW
    adder.input_b = LOW
    adder.carry_in = HIGH
    assert_high adder.sum
    assert_low adder.carry_out
  end

  def test_sum_is_low_and_carry_out_is_high_when_only_a_and_b_are_high
    adder.input_a = HIGH
    adder.input_b = HIGH
    adder.carry_in = LOW
    assert_low adder.sum
    assert_high adder.carry_out
  end

  def test_sum_is_low_and_carry_out_is_high_when_only_a_and_carry_in_are_high
    adder.input_a = HIGH
    adder.input_b = LOW
    adder.carry_in = HIGH
    assert_low adder.sum
    assert_high adder.carry_out
  end

  def test_sum_is_low_and_carry_out_is_high_when_only_b_and_carry_in_are_high
    adder.input_a = LOW
    adder.input_b = HIGH
    adder.carry_in = HIGH
    assert_low adder.sum
    assert_high adder.carry_out
  end

  def test_sum_and_carry_are_high_when_all_inputs_are_high
    adder.input_a = HIGH
    adder.input_b = HIGH
    adder.carry_in = HIGH
    assert_high adder.sum
    assert_high adder.carry_out
  end
end
