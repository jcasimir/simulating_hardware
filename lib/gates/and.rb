module Gates
  class And
    attr_accessor :input_a, :input_b

    include Hardware::Signals

    def output
      ((input_a == HIGH) && (input_b == HIGH)) ? HIGH : LOW
    end
  end
end