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

  def test_it_exists
    assert Adders::ALU
  end
end




