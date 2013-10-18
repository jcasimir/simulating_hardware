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
      puts "Building gates for #{input.bits}"
      @gates ||= build_gates(input.bits)
    end

    def build_gates(bits)
      puts "  Sub gates for #{bits}"
      gate = Gates::And.new

      if bits.count == 2
        gate.input_a = bits[1]
        gate.input_b = bits[0]
      else
        left  = bits[0...bits.count/2]
        right = bits[bits.count/2..-1]
        gate.input_a = build_gates(left)
        gate.input_b = build_gates(right)
      end

      puts "  Built #{ gate.inspect }"

      return gate
    end
  end
end