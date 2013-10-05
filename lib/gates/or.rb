require './lib/helpers/signals'
require './lib/gates/nand'
require './lib/gates/not'

module Gates
  class Or
    attr_accessor :input_a, :input_b

    include Helpers::Signals

    def initialize(args = {})
      @input_a = args[:input_a]
      @input_b = args[:input_b]
    end

    def output
      not_a = Not.new(input_a)
      not_b = Not.new(input_b)
      nand = Nand.new(input_a: not_a.output, input_b: not_b.output)
      nand.output
    end
  end
end
