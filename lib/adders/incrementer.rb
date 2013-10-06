require './lib/helpers/signals'
require './lib/helpers/binary'
require './lib/adders/full'

module Adders
  class Incrementer
    attr_accessor :input
    attr_reader   :size

    def initialize(bit_size)
      @size = bit_size
    end

    def output
      adder.output
    end

  private
    def adder
      @adder ||= build_adder
    end

    def build_adder
      adder = Adders::Ripple.new(size)
      adder.input_a = input
      adder.input_b = increment_by
      adder
    end

    def increment_by
      reversed_bits = Array.new(size){ 0 }
      reversed_bits[-1] = 1
      Helpers::Binary.from_bits(reversed_bits)
    end

  end
end