module Helpers
  class Binary
    include Helpers::Signals

    attr_reader :value

    def initialize(input)
      @value = input
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
