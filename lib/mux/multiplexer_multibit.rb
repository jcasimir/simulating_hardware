require './lib/mux/one_bit_multiplexer'

module Mux
  class MultiplexerMultibit
    attr_reader :size
    attr_accessor :control, :input_a, :input_b

    def initialize(bit_size)
      @size = bit_size
    end

    def output
      Helpers::Binary.from_bits output_bits
    end

  private

    def output_bits
      gates.collect{|g| g.output}.reverse
    end

    def gates
      @gates ||= build_gates
    end

    def build_gates
      (0...size).collect do |bit|
        mux = Mux::OneBitMultiplexer.new
        mux.input_a = lambda{ input_a.bits[bit] }
        mux.input_b = lambda{ input_b.bits[bit] }
        mux.control = lambda{ control }
        mux  
      end
    end
  end
end