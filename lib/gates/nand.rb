module Gates
  class Nand
    attr_accessor :input_a, :input_b

    include Hardware::Signals

    def initialize(inputs = {})
      self.input_a = inputs[:input_a]
      self.input_b = inputs[:input_b]
    end

    def output
      !((input_a == HIGH) && (input_b == HIGH)) ? HIGH : LOW
    end
  end
end