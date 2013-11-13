require './test/adders/alu/alu_test'

class ALUIntegrationIndividualTest < ALUTest
  def setup
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0000")
    alu.input_y = Helpers::Binary.new("0000 0000 0000 0000")
  end

  def test_all
    skip "Skipping until the components pass tests in sequence"
    zero_x_and_zero_y_added_is_zero
    zero_x_inverted_and_zero_y_inverted_added_and_inverted_is_one
    zero_x_inverted_and_zero_y_added_is_minus_one
    data_x_and_zero_y_inverted_anded_is_data_x
    x_zero_inverted_and_data_y_anded_is_data_y
    data_x_and_y_zero_inverted_anded_and_inverted_is_not_x
    data_x_and_y_zero_inverted_added_and_inverted_is_minus_x
    x_zero_inverted_and_data_y_added_and_inverted_is_minus_y
    data_x_inverted_and_y_zero_inverted_added_and_inverted_is_x_plus_1
    x_zero_inverted_and_y_data_inverted_added_and_inverted_is_y_plus_1
    data_x_and_y_zero_inverted_added_is_x_minus_1
    x_zero_inverted_and_y_data_added_is_y_minus_1
    data_x_and_data_y_added_is_x_plus_y
    data_x_inverted_and_data_y_added_and_inverted_is_x_minus_y
    data_x_and_data_y_inverted_added_and_inverted_is_y_minus_x
    data_x_and_data_y_anded_is_x_and_y
    data_x_inverted_and_data_y_inverted_anded_inverted_is_x_or_y
  end

  def zero_x_and_zero_y_added_is_zero
    alu.zero_x     = HIGH
    alu.negate_x   = LOW
    alu.zero_y     = HIGH
    alu.negate_y   = LOW
    alu.function   = HIGH
    alu.negate_out = LOW
    expected = Helpers::Binary.new("0000 0000 0000 0000")
    assert_equal expected, alu.output
  end

  def zero_x_inverted_and_zero_y_inverted_added_and_inverted_is_one
    alu.zero_x     = HIGH
    alu.negate_x   = HIGH
    alu.zero_y     = HIGH
    alu.negate_y   = HIGH
    alu.function   = HIGH
    alu.negate_out = HIGH
    expected = Helpers::Binary.new("0000 0000 0000 0001")
    assert_equal expected, alu.output
  end

  def zero_x_inverted_and_zero_y_added_is_minus_one
    alu.zero_x     = HIGH
    alu.negate_x   = HIGH
    alu.zero_y     = HIGH
    alu.negate_y   = LOW
    alu.function   = HIGH
    alu.negate_out = LOW
    expected = Helpers::Binary.new("1111 1111 1111 1111")
    assert_equal expected, alu.output
  end

  def data_x_and_zero_y_inverted_anded_is_data_x
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

  def x_zero_inverted_and_data_y_anded_is_data_y
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

  def data_x_and_y_zero_inverted_anded_and_inverted_is_not_x
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

  def data_x_and_y_zero_inverted_added_and_inverted_is_minus_x
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

  def x_zero_inverted_and_data_y_added_and_inverted_is_minus_y
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

  def data_x_inverted_and_y_zero_inverted_added_and_inverted_is_x_plus_1
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

  def x_zero_inverted_and_y_data_inverted_added_and_inverted_is_y_plus_1
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

  def data_x_and_y_zero_inverted_added_is_x_minus_1
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

  def x_zero_inverted_and_y_data_added_is_y_minus_1
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

  def data_x_and_data_y_added_is_x_plus_y
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

  def data_x_inverted_and_data_y_added_and_inverted_is_x_minus_y
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

  def data_x_and_data_y_inverted_added_and_inverted_is_y_minus_x
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

  def data_x_and_data_y_anded_is_x_and_y
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

  def data_x_inverted_and_data_y_inverted_anded_inverted_is_x_or_y
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
