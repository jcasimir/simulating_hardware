require './test/test_helper'
require './lib/gates/inverter'

class InverterTest < GateTest
  def gate
    @gate ||= Gates::Inverter.new(8)
  end

  def test_it_inverts_all_zeros
    gate.input = Helpers::Binary.new("0000 0000")
    expected   = Helpers::Binary.new("1111 1111")
    assert_equal expected, gate.output
  end

  def test_it_inverts_mixed_numbers
    gate.input = Helpers::Binary.new("1001 0110")
    expected   = Helpers::Binary.new("0110 1001")
    assert_equal expected, gate.output
  end
  
end
