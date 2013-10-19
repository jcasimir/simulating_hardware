require './lib/gates/and'

module Gates
  class AndMultibit
    attr_reader :size
    attr_accessor :input_a, :input_b

    include Helpers::Signals

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
        gate = Gates::And.new
        gate.input_a = lambda{ input_a.bits[bit] }
        gate.input_b = lambda{ input_b.bits[bit] }
        gate  
      end
    end

  end
end
