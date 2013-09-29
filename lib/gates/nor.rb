require './lib/signals'
require './lib/gates/nand'

module Gates
  class Nor
    attr_accessor :input_a, :input_b

    include Hardware::Signals

    def initialize(inputs = {})
      @input_a = inputs[:input_a]
      @input_b = inputs[:input_b]
    end

    def output
      or_gate = Or.new(input_a: input_a, input_b: input_b)
      not_gate = Not.new(or_gate.output)
      not_gate.output
    end
  end
end
