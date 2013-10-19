require './lib/helpers/signals'
require './lib/gates/nand'

module Gates
  class And
    attr_accessor :input_a, :input_b

    include Helpers::Signals

    def initialize(inputs = {})
      @input_a = inputs[:input_a]
      @input_b = inputs[:input_b]
    end

    def value_a
      if input_a.respond_to?(:call)
        input_a.call
      else
        input_a
      end
    end

    def value_b
      if input_b.respond_to?(:call)
        input_b.call
      else
        input_b
      end
    end

    def output
      nand_1 = Nand.new(input_a: value_a, input_b: value_b)
      nand_2 = Nand.new(input_a: value_a, input_b: value_b)
      nand_3 = Nand.new(input_a: nand_1.output, input_b: nand_2.output)
      nand_3.output
    end
  end
end
