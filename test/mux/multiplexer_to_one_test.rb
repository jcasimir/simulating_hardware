require './test/test_helper'
require './lib/mux/multiplexer_to_one'

class MultiplexerTest < GateTest
  def mux
    @mux ||= Mux::MultiplexerToOne.new(4)
  end

  def test_all_low_inputs_low_output
    mux.input = Helpers::Binary.new('0000')
    mux.control = Helpers::Binary.new('00')
    assert_low mux.output
  end

  def test_output_is_high_with_control_00_and_input_1000
    mux.input = Helpers::Binary.new('1000')
    mux.control = Helpers::Binary.new('00')
    assert_high mux.output
  end

  def test_output_is_high_with_control_01_and_input_0100
    mux.input = Helpers::Binary.new('0100')
    mux.control = Helpers::Binary.new('01')
    assert_high mux.output
  end

  def test_output_is_high_with_control_10_and_input_0010
    mux.input = Helpers::Binary.new('0010')
    mux.control = Helpers::Binary.new('10')
    assert_high mux.output
  end

  def test_output_is_high_with_control_11_and_input_0010
    mux.input = Helpers::Binary.new('0001')
    mux.control = Helpers::Binary.new('11')
    assert_high mux.output
  end
end
