require './test/test_helper'
require './lib/adders/half'

class HalfAdderTest < GateTest
  def adder
    @adder ||= Adders::Half.new
  end

  def test_both_sum_and_carry_are_zero_when_both_inputs_are_low
    adder.input_a = LOW
    adder.input_b = LOW
    assert_low adder.sum
    assert_low adder.carry
  end

  def test_sum_is_high_carry_is_low_when_a_is_high_but_b_is_low
    adder.input_a = HIGH
    adder.input_b = LOW
    assert_high adder.sum
    assert_low adder.carry
  end

  def test_sum_is_high_carry_is_low_when_b_is_high_but_a_is_low
    adder.input_a = LOW
    adder.input_b = HIGH
    assert_high adder.sum
    assert_low adder.carry
  end  

  def test_sum_is_low_carry_is_high_when_both_a_and_b_are_high
    adder.input_a = HIGH
    adder.input_b = HIGH
    assert_low adder.sum
    assert_high adder.carry
  end  
end
