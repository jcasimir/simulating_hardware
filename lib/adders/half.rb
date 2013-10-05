require './lib/helpers/signals'
require './lib/gates/xor'
require './lib/gates/and'

module Adders
  class Half
    attr_accessor :input_a, :input_b

    include Helpers::Signals

    def sum
      Gates::Xor.new(input_a: input_a, input_b: input_b).output
    end

    def carry
      Gates::And.new(input_a: input_a, input_b: input_b).output
    end
  end
end
