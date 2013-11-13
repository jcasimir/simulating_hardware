require './test/adders/alu/alu_test'

class XPinsTest < ALUTest
  def setup
    alu.zero_x = LOW
    alu.negate_x = LOW
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0000")
  end

  def test_zx_high_then_output_x_low
    alu.zero_x = HIGH
    alu.input_x = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal Helpers::Binary.new("0000 0000 0000 0000"), alu.send(:output_x)
  end

  def test_zx_low_the_x_is_preserved
    alu.zero_x = LOW
    alu.input_x = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal Helpers::Binary.new("1111 0000 1111 0000"), alu.send(:output_x)
  end

  def test_nx_high_then_output_negate_x_is_inverted
    alu.negate_x = HIGH
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0000")
    expected = Helpers::Binary.new("1111 1111 1111 1111")
    assert_equal expected, alu.send(:output_negate_x)
  end

  def test_nx_low_then_output_negate_x_is_not_inverted
    alu.negate_x = LOW
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0000")
    expected = Helpers::Binary.new("0000 0000 0000 0000")
    assert_equal expected, alu.send(:output_negate_x)
  end

  def test_nx_high_and_zx_high_then_output_x_negative_one
    alu.zero_x = HIGH
    alu.negate_x = HIGH
    assert_equal -1, alu.send(:output_x).to_decimal
  end
end

class XPinsMultiTest < ALUTest
  def setup
    alu.zero_x = LOW
    alu.negate_x = LOW
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0000")
  end

  def test_the_operations_in_sequence
    zx_high_then_output_x_low
    zx_low_the_x_is_preserved
    nx_high_then_output_negate_x_is_inverted
    nx_low_then_output_negate_x_is_not_inverted
    nx_high_and_zx_high_then_output_x_negative_one
  end

  def zx_high_then_output_x_low
    alu.zero_x = HIGH
    alu.input_x = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal Helpers::Binary.new("0000 0000 0000 0000"), alu.send(:output_x)
  end

  def zx_low_the_x_is_preserved
    alu.zero_x = LOW
    alu.input_x = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal Helpers::Binary.new("1111 0000 1111 0000"), alu.send(:output_x)
  end

  def nx_high_then_output_negate_x_is_inverted
    alu.negate_x = HIGH
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0000")
    expected = Helpers::Binary.new("1111 1111 1111 1111")
    assert_equal expected, alu.send(:output_negate_x)
  end

  def nx_low_then_output_negate_x_is_not_inverted
    alu.negate_x = LOW
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0000")
    expected = Helpers::Binary.new("0000 0000 0000 0000")
    assert_equal expected, alu.send(:output_negate_x)
  end

  def nx_high_and_zx_high_then_output_x_negative_one
    alu.zero_x = HIGH
    alu.negate_x = HIGH
    assert_equal -1, alu.send(:output_x).to_decimal
  end
end