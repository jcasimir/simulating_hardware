require './test/test_helper'
require './lib/gates/and_multibit'

class AndMultibitGateTest < GateTest
  def gate
    @gate ||= Gates::AndMultibit.new(8)
  end

  def test_it_exists
    assert gate
  end

  def test_it_works_like_a_normal_and
    two_input = Gates::AndMultibit.new(2)
    two_input.input = Helpers::Binary.new("11")
    assert_high two_input.output
    two_input.input = Helpers::Binary.new("10")
    assert_low two_input.output
    two_input.input = Helpers::Binary.new("01")
    assert_low two_input.output
    two_input.input = Helpers::Binary.new("00")
    assert_low two_input.output
  end

  def test_it_is_high_with_all_inputs_high
    gate.input = Helpers::Binary.new("11111111")
    assert_high gate.output
  end

  def test_it_is_low_with_any_low_input
    inputs = ["0111 1111", "1100 1100", "0000 0000", "0000 0001"]
    inputs.each do |input|
      gate.input = Helpers::Binary.new(input)
      assert_low gate.output
    end
  end

  def test_it_handles_changing_manybit_input
    gate.input = Helpers::Binary.new("11111111")
    assert_high gate.output
    gate.input = Helpers::Binary.new("1100 1100")
    assert_low gate.output
    gate.input = Helpers::Binary.new("11111111")
    assert_high gate.output
  end
end