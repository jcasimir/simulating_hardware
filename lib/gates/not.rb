require './lib/signals'
require './lib/gates/nand'

module Gates
  class Not
    attr_accessor :input

    include Hardware::Signals

    def initialize(input = LOW)
      raise ArgumentError.new("Invalid input") unless SIGNALS.include?(input)
      @input = input
    end

    def output
      gates.output
    end

  private

    def gates
      Nand.new(input_a: input, input_b: input)
    end
  end
end
