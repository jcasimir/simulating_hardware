module Gates
  class Not
    attr_accessor :input

    include Hardware::Signals

    def output
      gates.output
    end

  private

    def gates
      Nand.new(input_a: input, input_b: input)
    end
  end
end
