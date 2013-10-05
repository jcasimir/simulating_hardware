require './lib/gates/not'
require './lib/gates/and'

module Mux
  class OneBitDemultiplexer
    attr_accessor :input, :control

    include Hardware::Signals

    def output_a
      Gates::And.new(input_a: input, input_b: not_control).output
    end

    def output_b
      Gates::And.new(input_a: input, input_b: control).output
    end

    def state
      {
        :input => input,
        :control => control,
        :not_control => not_control,
        :output_a => output_a,
        :output_b => output_b
      }
    end

  private
    def not_control
      Gates::Not.new(control).output
    end
  end
end