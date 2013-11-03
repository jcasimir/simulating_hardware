require './test/adders/alu/alu_test'

class FunctionPinsTest < ALUTest
  def setup
    alu.zero_x = LOW
    alu.zero_y = LOW
    alu.negate_y = LOW
    alu.negate_x = LOW
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