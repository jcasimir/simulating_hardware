module Helpers
  class Binary
    include Helpers::Signals

    attr_reader :value

    def initialize(input)
      @value = input
    end

    def self.from_bits(input)
      new(input.join)
    end

    def to_s
      value
    end

    def bits
      value.reverse.scan(/\d/).collect{|bit| convert(bit)}
    end

    def ==(other)
      self.bits == other.bits
    end

    def size
      bits.size
    end

  private
    def convert(bit)
      if bit.to_i == HIGH
        HIGH
      else
        LOW
      end
    end
  end
end
