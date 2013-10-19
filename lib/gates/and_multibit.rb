require './lib/gates/and'

module Gates
  class AndMultibit
    attr_reader :size
    attr_accessor :input

    include Helpers::Signals

    def initialize(bit_size)
      @size = bit_size
    end

    def output
      gates.output
    end

  private

    def gates
      @gates ||= build_gates((0...size).to_a)
    end

    def build_gates(bit_positions)
      gate = Gates::And.new

      if bit_positions.count == 2
        gate.input_a = lambda { input.bits[bit_positions[1]] }
        gate.input_b = lambda { input.bits[bit_positions[0]] }
      else
        left, right = bit_positions.each_slice( (bit_positions.size/2) ).to_a
        gate.input_a = lambda { build_gates(left).output }
        gate.input_b = lambda { build_gates(right).output }
      end

      return gate
    end
  end
end