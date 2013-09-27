require './lib/signals'
require './lib/gates/nand'

module Gates
  class Xor
    attr_accessor :input_a, :input_b

    include Hardware::Signals

    def output
      n1 = a_nand_b = Nand.new(input_a: input_a, input_b: input_b)
      a_nand_n1 = Nand.new(input_a: input_a, input_b: n1.output)
      b_nand_n1 = Nand.new(input_a: n1.output, input_b: input_b)
      n4 = Nand.new(input_a: a_nand_n1.output, input_b: b_nand_n1.output)
      n4.output
    end
  end
end
