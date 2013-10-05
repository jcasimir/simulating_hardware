require './lib/helpers/signals'
require './lib/gates/xor'
require './lib/gates/and'
require './lib/gates/or'

module Adders
  class Full
    attr_accessor :input_a, :input_b, :carry_in

    include Helpers::Signals

    def sum
      Gates::Xor.new(input_a: xor_a_b, input_b: carry_in).output
    end

    def carry_out
      Gates::Or.new(input_a: and_carry_in_with_xor_a_b, input_b: and_a_b).output
    end

  private
    def xor_a_b
      Gates::Xor.new(input_a: input_a, input_b: input_b).output
    end

    def and_a_b
      Gates::And.new(input_a: input_a, input_b: input_b).output
    end

    def and_carry_in_with_xor_a_b
      Gates::And.new(input_a: carry_in, input_b: xor_a_b).output
    end
  end
end
