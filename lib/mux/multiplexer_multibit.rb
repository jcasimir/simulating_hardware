require './lib/mux/one_bit_multiplexer'

module Mux
  class MultiplexerMultibit
    attr_reader :size
    attr_accessor :input_a, :input_b

    include Helpers::Signals

    def control=(control_in)
      @control = control_in
    end

    def control
      value_of(@control)
    end

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
        if control.respond_to?(:call)
          mux.control = control
        else
          mux.control = lambda{ control }
        end
        mux  
      end
    end
  end
end