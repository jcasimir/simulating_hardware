require './lib/helpers/signals'

module Gates
  class Nand
    attr_accessor :input_a, :input_b

    include Helpers::Signals

    def initialize(inputs = {})
      self.input_a = inputs[:input_a]
      self.input_b = inputs[:input_b]
    end

    def output
      !((value_of(input_a) == HIGH) && (value_of(input_b) == HIGH)) ? HIGH : LOW
    end
  end
end
