module Memory
  class DataFlipFlop
    include Helpers::Signals

    attr_accessor :input
    attr_reader :output

    def initialize(input_clock)
      input_clock.add_subscriber(self)
    end

    def tick
      @output = input
    end
  end
end