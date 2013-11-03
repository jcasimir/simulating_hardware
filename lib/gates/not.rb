require './lib/helpers/signals'
require './lib/gates/nand'

module Gates
  class Not
    attr_accessor :input

    include Helpers::Signals

    def initialize(input = LOW)
      unless SIGNALS.include?(input)
        raise ArgumentError.new("Invalid input: #{input.inspect}") 
      end
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
