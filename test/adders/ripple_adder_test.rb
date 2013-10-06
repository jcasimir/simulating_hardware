require './test/test_helper'
require './lib/adders/ripple'
require './lib/helpers/binary'

class RippleAdderTest < GateTest
  def adder
    @adder ||= Adders::Ripple.new(8)
  end

  def test_zero_inputs_add_to_zero_outputs
    adder.input_a = Helpers::Binary.new('00000000')
    adder.input_b = Helpers::Binary.new('00000000')
    assert_equal Helpers::Binary.new('00000000'), adder.output
  end

  def test_add_one_to_zero
    adder.input_a = Helpers::Binary.new('00000000')
    adder.input_b = Helpers::Binary.new('00000001')
    assert_equal Helpers::Binary.new('00000001'), adder.output
  end

  def test_add_one_to_one
    adder.input_a = Helpers::Binary.new('00000001')
    adder.input_b = Helpers::Binary.new('00000001')
    assert_equal Helpers::Binary.new('00000010'), adder.output
  end

  def test_overflow_does_not_error
    adder.input_a = Helpers::Binary.new('00000001')
    adder.input_b = Helpers::Binary.new('11111111')
    assert_equal Helpers::Binary.new('00000000'), adder.output
  end

  def test_adders_work_as_expected_at_a_size_of_16
    big_adder = Adders::Ripple.new(16)
    big_adder.input_a = Helpers::Binary.new('0000 0000 0000 0001')
    big_adder.input_b = Helpers::Binary.new('1111 1111 1111 1111')
    assert_equal Helpers::Binary.new('0000 0000 0000 0000'), big_adder.output
  end

  def test_adders_ensure_the_proper_sized_input_a
    assert_raises(ArgumentError) do 
      adder.input_a = Helpers::Binary.new('0000 0000 0000 0001')
    end
  end

  def test_adders_ensure_the_proper_sized_input_b
    assert_raises(ArgumentError) do 
      adder.input_b = Helpers::Binary.new('0000 0000 0000 0001')
    end
  end
end
