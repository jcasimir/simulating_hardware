require './lib/gates/nand'

module Memory
  class DataFlipFlop
    include Helpers::Signals

    attr_accessor :input
    attr_reader :clock

    def initialize(input_clock)
      @clock = input_clock
      input_clock.add_subscriber(self)
    end

    def tick
      @next_out = input
    end

    def output
      value_of(@next_out)
    end

  private
    def gate_output
      gates.output
    end

    def gates
      nand6
    end

    def nand1
      gate = Gates::Nand.new(:input_a => input, :input_b => lambda{ nand2.output })
    end

    def nand2
      gate = Gates::Nand.new(:input_a => lambda{ nand3.output }, :input_b => lambda{ clock }, :input_c => lambda{ nand1.output })
    end

    def nand3
      gate = Gates::Nand.new(:input_a => lambda{ nand4.output }, :input_b => lambda{ clock })
    end

    def nand4
      gate = Gates::Nand.new(:input_a => lambda{ nand1.output }, :input_b => lambda{ nand3.output })
    end

    def nand5
      gate = Gates::Nand.new(:input_a => lambda{ nand6.output }, :input_b => lambda{ nand2.output })
    end

    def nand6
      gate = Gates::Nand.new(:input_a => lambda{ nand3.output }, :input_b => lambda{ nand5.output })
    end
  end
end