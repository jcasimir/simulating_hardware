require './test/test_helper'
require './lib/adders/alu'

class ALUTest < GateTest
  def alu
    @alu ||= Adders::ALU.new
  end
end

class ALUIntegrationTest < ALUTest
  def setup
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0000")
    alu.input_y = Helpers::Binary.new("0000 0000 0000 0000")
  end

  def test_zero_x_and_zero_y_added_is_zero
    alu.zero_x     = HIGH
    alu.negate_x   = LOW
    alu.zero_y     = HIGH
    alu.negate_y   = LOW
    alu.function   = HIGH
    alu.negate_out = LOW
    expected = Helpers::Binary.new("0000 0000 0000 0000")
    assert_equal expected, alu.output
  end

  def test_zero_x_inverted_and_zero_y_inverted_added_and_inverted_is_one
    alu.zero_x     = HIGH
    alu.negate_x   = HIGH
    alu.zero_y     = HIGH
    alu.negate_y   = HIGH
    alu.function   = HIGH
    alu.negate_out = HIGH
    expected = Helpers::Binary.new("0000 0000 0000 0001")
    assert_equal expected, alu.output
  end

  def test_zero_x_inverted_and_zero_y_added_is_minus_one
    alu.zero_x     = HIGH
    alu.negate_x   = HIGH
    alu.zero_y     = HIGH
    alu.negate_y   = LOW
    alu.function   = HIGH
    alu.negate_out = LOW
    expected = Helpers::Binary.new("1111 1111 1111 1111")
    assert_equal expected, alu.output
  end

  def test_data_x_and_zero_y_inverted_anded_is_data_x
    alu.zero_x     = LOW
    alu.negate_x   = LOW
    alu.zero_y     = HIGH
    alu.negate_y   = HIGH
    alu.function   = LOW
    alu.negate_out = LOW
    alu.input_x = Helpers::Binary.new("1111 0000 1111 0000")
    expected = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal expected, alu.output
  end

  def test_x_zero_inverted_and_data_y_anded_is_data_y
    alu.zero_x     = HIGH
    alu.negate_x   = HIGH
    alu.zero_y     = LOW
    alu.negate_y   = LOW
    alu.function   = LOW
    alu.negate_out = LOW
    alu.input_y = Helpers::Binary.new("1111 0110 1111 0000")
    expected = Helpers::Binary.new("1111 0110 1111 0000")
    assert_equal expected, alu.output
  end

  def test_data_x_and_y_zero_inverted_anded_and_inverted_is_not_x
    alu.zero_x     = LOW
    alu.negate_x   = LOW
    alu.zero_y     = HIGH
    alu.negate_y   = HIGH
    alu.function   = LOW
    alu.negate_out = HIGH
    alu.input_x = Helpers::Binary.new("1111 0110 1111 0000")
    expected = Helpers::Binary.new("0000 1001 0000 1111")
    assert_equal expected, alu.output
  end

  def test_data_x_and_y_zero_inverted_added_and_inverted_is_minus_x
    alu.zero_x     = LOW
    alu.negate_x   = LOW
    alu.zero_y     = HIGH
    alu.negate_y   = HIGH
    alu.function   = HIGH
    alu.negate_out = HIGH
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0111")
    expected_decimal = -7
    assert_equal expected_decimal, alu.output.to_decimal
  end

  def test_x_zero_inverted_and_data_y_added_and_inverted_is_minus_y
    alu.zero_x     = HIGH
    alu.negate_x   = HIGH
    alu.zero_y     = LOW
    alu.negate_y   = LOW
    alu.function   = HIGH
    alu.negate_out = HIGH
    alu.input_y = Helpers::Binary.new("0000 0000 0000 0111")
    expected_decimal = -7
    assert_equal expected_decimal, alu.output.to_decimal
  end

  def test_data_x_inverted_and_y_zero_inverted_added_and_inverted_is_x_plus_1
    alu.zero_x     = LOW
    alu.negate_x   = HIGH
    alu.zero_y     = HIGH
    alu.negate_y   = HIGH
    alu.function   = HIGH
    alu.negate_out = HIGH
    alu.input_x = Helpers::Binary.new("0000 0000 0000 1111")
    expected = Helpers::Binary.new("0000 0000 0001 0000")
    assert_equal expected, alu.output
  end

  def test_x_zero_inverted_and_y_data_inverted_added_and_inverted_is_y_plus_1
    alu.zero_x     = HIGH
    alu.negate_x   = HIGH
    alu.zero_y     = LOW
    alu.negate_y   = HIGH
    alu.function   = HIGH
    alu.negate_out = HIGH
    alu.input_y = Helpers::Binary.new("0000 0000 0000 1111")
    expected = Helpers::Binary.new("0000 0000 0001 0000")
    assert_equal expected, alu.output
  end

  def test_data_x_and_y_zero_inverted_added_is_x_minus_1
    alu.zero_x     = LOW
    alu.negate_x   = LOW
    alu.zero_y     = HIGH
    alu.negate_y   = HIGH
    alu.function   = HIGH
    alu.negate_out = LOW
    alu.input_x = Helpers::Binary.new("0000 0000 0001 0000")
    expected = Helpers::Binary.new("0000 0000 0000 1111")
    assert_equal expected, alu.output
  end

  def test_x_zero_inverted_and_y_data_added_is_y_minus_1
    alu.zero_x     = HIGH
    alu.negate_x   = HIGH
    alu.zero_y     = LOW
    alu.negate_y   = LOW
    alu.function   = HIGH
    alu.negate_out = LOW
    alu.input_y = Helpers::Binary.new("0000 0000 0001 0000")
    expected = Helpers::Binary.new("0000 0000 0000 1111")
    assert_equal expected, alu.output
  end

  def test_data_x_and_data_y_added_is_x_plus_y
    alu.zero_x     = LOW
    alu.negate_x   = LOW
    alu.zero_y     = LOW
    alu.negate_y   = LOW
    alu.function   = HIGH
    alu.negate_out = LOW
    alu.input_x = Helpers::Binary.new("0000 0000 0001 0000")
    alu.input_y = Helpers::Binary.new("0000 0000 0001 0011")
    expected    = Helpers::Binary.new("0000 0000 0010 0011")
    assert_equal expected, alu.output
  end

  def test_data_x_inverted_and_data_y_added_and_inverted_is_x_minus_y
    alu.zero_x     = LOW
    alu.negate_x   = HIGH
    alu.zero_y     = LOW
    alu.negate_y   = LOW
    alu.function   = HIGH
    alu.negate_out = HIGH
    alu.input_x = Helpers::Binary.new("0000 0000 0000 1110")
    alu.input_y = Helpers::Binary.new("0000 0000 0000 0011")
    expected    = Helpers::Binary.new("0000 0000 0000 1011")
    assert_equal expected, alu.output
  end

  def test_data_x_and_data_y_inverted_added_and_inverted_is_y_minus_x
    alu.zero_x     = LOW
    alu.negate_x   = LOW
    alu.zero_y     = LOW
    alu.negate_y   = HIGH
    alu.function   = HIGH
    alu.negate_out = HIGH
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0011")
    alu.input_y = Helpers::Binary.new("0000 0000 0000 1110")
    expected    = Helpers::Binary.new("0000 0000 0000 1011")
    assert_equal expected, alu.output
  end

  def test_data_x_and_data_y_anded_is_x_and_y
    alu.zero_x     = LOW
    alu.negate_x   = LOW
    alu.zero_y     = LOW
    alu.negate_y   = LOW
    alu.function   = LOW
    alu.negate_out = LOW
    alu.input_x = Helpers::Binary.new("0000 0000 0001 0011")
    alu.input_y = Helpers::Binary.new("0000 0000 0001 1001")
    expected    = Helpers::Binary.new("0000 0000 0001 0001")
    assert_equal expected, alu.output
  end

  def test_data_x_inverted_and_data_y_inverted_anded_inverted_is_x_or_y
    alu.zero_x     = LOW
    alu.negate_x   = HIGH
    alu.zero_y     = LOW
    alu.negate_y   = HIGH
    alu.function   = LOW
    alu.negate_out = HIGH
    alu.input_x = Helpers::Binary.new("0000 0000 0001 0011")
    alu.input_y = Helpers::Binary.new("0000 0000 0001 1001")
    expected    = Helpers::Binary.new("0000 0000 0001 1011")
    assert_equal expected, alu.output
  end
end

class XPinsTest < ALUTest
  def setup
    alu.zero_x = LOW
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

class YPinsTest < ALUTest
  def test_zy_high_then_output_y_zero
    alu.zero_y = HIGH
    alu.input_y = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal Helpers::Binary.new("0000 0000 0000 0000"), alu.send(:output_y)
  end

  def test_zy_low_the_y_is_preserved
    alu.zero_y = LOW
    alu.input_y = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal Helpers::Binary.new("1111 0000 1111 0000"), alu.send(:output_y)
  end

  def test_ny_high_then_output_negate_y_is_inverted
    alu.negate_y = HIGH
    alu.input_y = Helpers::Binary.new("0000 0000 0000 0000")
    expected = Helpers::Binary.new("1111 1111 1111 1111")
    assert_equal expected, alu.send(:output_negate_y)
  end

  def test_ny_low_then_output_negate_y_is_not_inverted
    alu.negate_y = LOW
    alu.input_y = Helpers::Binary.new("0000 0000 0000 0000")
    expected = Helpers::Binary.new("0000 0000 0000 0000")
    assert_equal expected, alu.send(:output_negate_y)
  end

  def test_ny_high_and_zy_high_then_output_y_negative_one
    alu.zero_y = HIGH
    alu.negate_y = HIGH
    assert_equal -1, alu.send(:output_y).to_decimal
  end
end

class FunctionPinsTest < ALUTest
  def setup
    alu.zero_x = LOW
  end

  def test_f_high_adds_x_and_y
    alu.function = HIGH
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0001")
    alu.input_y = Helpers::Binary.new("0000 0000 0000 1111")
    expected = Helpers::Binary.new("0000 0000 0001 0000")
    assert_equal expected, alu.send(:output_function)
  end

  def test_f_low_ands_x_and_y
    alu.function = LOW
    alu.input_x = Helpers::Binary.new("0000 0000 1111 0001")
    alu.input_y = Helpers::Binary.new("0000 0000 1000 1111")
    expected = Helpers::Binary.new("0000 0000 1000 0001")
    assert_equal expected, alu.send(:output_function)
  end

  def test_negate_output_high_bitwise_inverts_the_output
    alu.negate_out = HIGH
    alu.function = LOW
    alu.input_x = Helpers::Binary.new("0000 0000 1111 0001")
    alu.input_y = Helpers::Binary.new("0000 0000 1000 1111")
    original_expected = Helpers::Binary.new("0000 0000 1000 0001")
    expected = original_expected.inverse
    assert_equal expected, alu.send(:output_negate_out)
  end

  def test_negate_output_low_keeps_the_function_output
    alu.negate_out = LOW
    alu.function = LOW
    alu.input_x = Helpers::Binary.new("0000 0000 1111 0001")
    alu.input_y = Helpers::Binary.new("0000 0000 1000 1111")
    expected = Helpers::Binary.new("0000 0000 1000 0001")
    assert_equal expected, alu.send(:output_negate_out)
  end
end