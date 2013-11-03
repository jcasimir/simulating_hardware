require './test/test_helper'
require './lib/adders/alu'

class ALUTest < GateTest
  def alu
    @alu ||= Adders::ALU.new
  end
end