require './lib/helpers/signals'
require './lib/gates/nand'

module Gates
  class Nor
    attr_accessor :input_a, :input_b

    include Helpers::Signals

    def output
      or_gate = Or.new(input_a: input_a, input_b: input_b)
      not_gate = Not.new(or_gate.output)
      not_gate.output
    end
  end
end
