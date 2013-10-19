require './lib/mux/one_bit_multiplexer'

module Mux
  class MultiplexerToOne
    attr_reader :size, :input, :control

    def initialize(bit_size)
      @size = bit_size
    end

    def input=(data)
      @input = data
    end

    def control=(data)
      @control = data
    end

    def output
      muxes.output
    end

  private
    def muxes
      @muxes ||= build_mux(input.bits, 0)
    end

    def build_mux(inputs, depth)
      mux = Mux::OneBitMultiplexer.new

      if inputs.count == 2
        mux.input_a = inputs[1]
        mux.input_b = inputs[0]
      else
        left  = inputs[0...inputs.count/2]
        right = inputs[inputs.count/2..-1]
        mux.input_b = build_mux(left, depth+1).output
        mux.input_a = build_mux(right, depth+1).output
      end

      mux.control = control.bits.reverse[depth]
      return mux
    end
  end
end