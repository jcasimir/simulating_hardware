require './lib/gates/not'
require './lib/gates/or'
require './lib/gates/and'

module Mux
  class OneBitMultiplexer
    attr_accessor :input_a, :input_b, :control

    include Helpers::Signals

    def output
      Gates::Or.new(input_a: input_a_and_not_control, input_b: input_b_and_control).output
    end

  private
    def not_control
      Gates::Not.new(value_of(control)).output
    end

    def input_a_and_not_control
      Gates::And.new(input_a: value_of(input_a), input_b: not_control).output
    end

    def input_b_and_control
      Gates::And.new(input_a: value_of(input_b), input_b: value_of(control)).output
    end
  end
end