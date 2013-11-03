require './lib/helpers/signals'
require './lib/gates/nand'

module Gates
  class Inverter
    attr_accessor :input
    attr_reader   :size

    include Helpers::Signals

    def initialize(size)
      @size = size
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
        gate = Gates::Nand.new
        gate.input_a = lambda{ value_of(input).bits[bit] }
        gate.input_b = lambda{ value_of(input).bits[bit] }
        gate
      end
    end
  end
end
