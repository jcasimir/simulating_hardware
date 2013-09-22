require './lib/gates/nand'

module Gates
  class And
    attr_accessor :input_a, :input_b

    include Hardware::Signals

    def output
      nand_1 = Nand.new(input_a: input_a, input_b: input_b)
      nand_2 = Nand.new(input_a: input_a, input_b: input_b)
      nand_3 = Nand.new(input_a: nand_1.output, input_b: nand_2.output)
      nand_3.output
    end
  end
end