require './test/test_helper'
require './lib/mux/multiplexer_multibit'

class MultiplexerMultibitTest < GateTest
  def mux
    @mux ||= Mux::MultiplexerMultibit.new(8)
  end

  def test_with_low_inputs_it_outputs_low
    mux.control = LOW
    mux.input_a = Helpers::Binary.new("0000 0000")
    mux.input_b = Helpers::Binary.new("0000 0000")
    expected    = Helpers::Binary.new("0000 0000")
    assert_equal expected, mux.output
  end
end