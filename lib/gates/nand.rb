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
      !((value_a == HIGH) && (value_b == HIGH)) ? HIGH : LOW
    end

  private
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
  end
end
