require './test/test_helper'
require './lib/gates/and_multibit'

class AndMultibitGateTest < GateTest
  def gate
    @gate ||= Gates::AndMultibit.new(8)
  end

  def test_it_handles_changing_manybit_input
    gate.input_a = Helpers::Binary.new("01110101")
    gate.input_b = Helpers::Binary.new("11010111")
    expected     = Helpers::Binary.new("01010101")
    assert_equal expected, gate.output

    gate.input_a = Helpers::Binary.new("10000000")
    gate.input_b = Helpers::Binary.new("11010111")
    expected     = Helpers::Binary.new("10000000")
    assert_equal expected, gate.output  
  end
end