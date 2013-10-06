module Adders
  class Ripple
    attr_accessor :input_a, :input_b
    attr_reader :size

    include Helpers::Signals

    def initialize(bit_size)
      @size = bit_size
    end

    def output
      Helpers::Binary.from_bits(adders_output)
    end

  private
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
        adders[i].input_a = input_a.bits[i]
        adders[i].input_b = input_b.bits[i]
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
