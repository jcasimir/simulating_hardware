require './test/adders/alu/alu_test'

class YPinsTest < ALUTest
  def setup
    alu.zero_y = LOW
    alu.negate_y = LOW
    alu.input_y = Helpers::Binary.new("0000 0000 0000 0000")
  end

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