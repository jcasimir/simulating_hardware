require './lib/gates/not'

module Mux
  class OneBitMultiplexer
    attr_accessor :input_a, :input_b, :control

    include Hardware::Signals

    def output
      not_control = Gates::Not.new(input: control)
      a_and_not_control = Gates::And.new(input_a: input_a, input_b: not_control.output)
      b_and_control = Gates::And.new(input_a: input_b, input_b: control)
      anotc_or_bc = Gates::Or.new(input_a: a_and_not_control.output, input_b: b_and_control.output)
      anotc_or_bc.output
    end
  end
end