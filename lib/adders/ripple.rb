require './lib/adders/full'

module Adders
  class Ripple
    attr_reader :size, :input_a, :input_b

    include Helpers::Signals

    def initialize(bit_size)
      @size = bit_size
    end

    def output
      Helpers::Binary.from_bits(adders_output)
    end

    def input_a=(input)
      raise ArgumentError unless validate_size_of(input)
      @input_a = input
    end

    def input_b=(input)
      raise ArgumentError unless validate_size_of(input)
      @input_b = input 
    end

  private
    def validate_size_of(input)
      size == input.size
    end

    def adders
      @adders ||= build_adders
    end

    def adders_output
      adders.collect{|a| a.sum}.reverse
    end

    def build_adders
      adders = []
      size.times do |i|
        adders[i] = Adders::Full.new
        adders[i].input_a = value_of(input_a).bits[i]
        adders[i].input_b = value_of(input_b).bits[i]
        if i == 0
          adders[i].carry_in = LOW
        else
          adders[i].carry_in = adders[i-1].carry_out
        end
      end
      adders
    end
  end
end
