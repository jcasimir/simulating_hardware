require './test/test_helper'
require './lib/helpers/binary'

class BinaryTest < GateTest
  def test_it_converts_zero_input_to_an_array_of_low
    b = Helpers::Binary.new('0')
    assert_equal 1, b.bits.count
    assert_equal LOW, b.bits[0]
  end

  def test_it_zero_pads_input_to_the_specified_size
    a = Helpers::Binary.new('01', 8)
    b = Helpers::Binary.new('0000 0001')
    assert_equal b, a
  end

  def test_it_converts_101010_input_to_an_array_of_high_low_values
    b = Helpers::Binary.new('101010')
    assert_equal 6, b.bits.count
    assert_low b.bits[0]
    assert_high b.bits[1]
    assert_low b.bits[2]
    assert_high b.bits[3]
    assert_low b.bits[4]
    assert_high b.bits[5]
  end

  def test_it_equates_instances_based_on_digits
    a = Helpers::Binary.new('101010')
    b = Helpers::Binary.new('101010')
    assert_equal a, b
  end

  def test_it_allows_spaces_in_the_input_string
    a = Helpers::Binary.new('10 10 10')
    b = Helpers::Binary.new('101010')
    assert_equal a, b
  end

  def test_it_builds_representations_from_arrays_of_bits
    a = Helpers::Binary.new('10 10 10')
    b = Helpers::Binary.from_bits([1, 0, 1, 0, 1, 0])
    assert_equal a, b
  end

  def test_it_exposes_the_bit_size
    assert_equal 4, Helpers::Binary.new("0000").size
  end

  def test_it_converts_positive_binary_to_decimal
    assert_equal 1, Helpers::Binary.new("0001").to_decimal
  end

  def test_it_converts_negative_binary_to_decimal
    assert_equal -1, Helpers::Binary.new("1111").to_decimal
    assert_equal -2, Helpers::Binary.new("1110").to_decimal
  end

  def test_it_inverts
    a = Helpers::Binary.new('1010')
    not_a = Helpers::Binary.new('0101')
    assert_equal not_a, a.inverse
  end

  def test_it_adds
    a = Helpers::Binary.new('1010')
    b = Helpers::Binary.new('0001')
    sum = Helpers::Binary.new('1011')
    assert_equal sum, a + b
  end

  def test_it_adds_and_carries
    a = Helpers::Binary.new('1010')
    b = Helpers::Binary.new('0001')
    sum = Helpers::Binary.new('1011')
    assert_equal sum, a + b
  end

  def test_it_add_and_clips_overflow
    a = Helpers::Binary.new('1111')
    b = Helpers::Binary.new('0001')
    sum = Helpers::Binary.new('0000')
    assert_equal sum, a + b
  end

  def test_it_only_adds_like_sized_numbers
    a = Helpers::Binary.new('1111')
    b = Helpers::Binary.new('01')
    assert_raises ArgumentError do
      a + b
    end
  end
end
