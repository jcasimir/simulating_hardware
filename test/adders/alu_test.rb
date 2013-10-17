# zero-x: if ZX then x = 0
# bit-wise negate X: if nx then x = !x
# zero the y: if zy then y = 0
# negate the y: if ny then y = !y
# function code: if f then out = x + y
#                if !f then out = x & y
# negate output: if no then out = !out


# ZX NX ZY NY F NO OUTPUT
# 1  0  1  0  1 0   0
# 1  1  1  1  1 1   1
# 1  1  1  0  1 0  -1
# 0  0  1  1  0 0   x
# 1  1  0  0  0 0   y
# 0  0  1  1  0 1  !x
# 1  1  0  0  0 1  !y
# 0  0  1  1  1 1  -x
# 1  1  0  0  1 1  -y
# 0  1  1  1  1 1  x+1
# more...

require './test/test_helper'
require './lib/adders/alu'

class ALUTest < GateTest
  def alu
    @alu ||= Adders::ALU.new
  end
end

class XPinsTest < ALUTest
  def test_zx_high_then_output_x_low
    alu.zero_x = HIGH
    alu.input_x = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal Helpers::Binary.new("0000 0000 0000 0000"), alu.output_x
  end

  def test_zx_low_the_x_is_preserved
    alu.zero_x = LOW
    alu.input_x = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal Helpers::Binary.new("1111 0000 1111 0000"), alu.output_x
  end

  def test_nx_high_then_output_negate_x_is_inverted
    alu.negate_x = HIGH
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0000")
    expected = Helpers::Binary.new("1111 1111 1111 1111")
    assert_equal expected, alu.output_negate_x
  end

  def test_nx_low_then_output_negate_x_is_not_inverted
    alu.negate_x = LOW
    alu.input_x = Helpers::Binary.new("0000 0000 0000 0000")
    expected = Helpers::Binary.new("0000 0000 0000 0000")
    assert_equal expected, alu.output_negate_x
  end

  def test_nx_high_and_zx_high_then_output_x_negative_one
    alu.zero_x = HIGH
    alu.negate_x = HIGH
    assert_equal -1, alu.output_x.to_decimal
  end
end

class YPinsTest < ALUTest
  def test_zy_high_then_output_y_zero
    alu.zero_y = HIGH
    alu.input_y = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal Helpers::Binary.new("0000 0000 0000 0000"), alu.output_y
  end

  def test_zy_low_the_y_is_preserved
    alu.zero_y = LOW
    alu.input_y = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal Helpers::Binary.new("1111 0000 1111 0000"), alu.output_y
  end

  def test_ny_high_then_output_negate_y_is_inverted
    alu.negate_y = HIGH
    alu.input_y = Helpers::Binary.new("0000 0000 0000 0000")
    expected = Helpers::Binary.new("1111 1111 1111 1111")
    assert_equal expected, alu.output_negate_y
  end

  def test_ny_low_then_output_negate_y_is_not_inverted
    alu.negate_y = LOW
    alu.input_y = Helpers::Binary.new("0000 0000 0000 0000")
    expected = Helpers::Binary.new("0000 0000 0000 0000")
    assert_equal expected, alu.output_negate_y
  end

  def test_ny_high_and_zy_high_then_output_y_negative_one
    alu.zero_y = HIGH
    alu.negate_y = HIGH
    assert_equal -1, alu.output_y.to_decimal
  end
end
