module Timing
  class Clock
    include Helpers::Signals

    def initialize
      @signal = LOW
    end

    def tick
      @signal = (@signal == LOW ? HIGH : LOW)
    end

    def output
      @signal
    end
  end
end