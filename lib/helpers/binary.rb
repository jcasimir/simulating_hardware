module Helpers
  class Binary
    include Helpers::Signals

    attr_reader :value

    def initialize(input, bit_size = nil)
      if bit_size
        input = input.rjust(bit_size, "0")
      end
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
      unless other.respond_to?(:bits)
        raise "Can't compare #{self.inspect} to #{other.inspect} (#{other.class})"
      end
      self.bits == other.bits
    end

    def size
      bits.size
    end

    def to_decimal
      if bits.last == 1
        (self.inverse + Binary.new("1", self.size)).to_decimal * -1
      else
        value.to_i(2)
      end
    end

    def inverse
      bits = value.scan(/\d/).collect do |original|
        original == "1" ? "0" : "1"
      end.join
      Binary.new(bits)
    end

    def +(other)
      unless self.size == other.size
        raise ArgumentError.new("numbers to be added must have the same number of bits")
      end

      bit_pairs = bits.zip(other.bits)
      carry = 0
      result = bit_pairs.collect do |a, b|
        if a + b + carry == 3
          carry = 1
          1
        elsif a + b + carry  == 2
          carry = 1
          0
        elsif a + b + carry == 1
          carry = 0
          1
        else
          carry = 0
          0
        end
      end
      Binary.new(result.reverse.join)
    end

    def &(other)
      unless self.size == other.size
        raise ArgumentError.new("numbers to be anded must have the same number of bits")
      end

      bit_pairs = bits.zip(other.bits)
      result = bit_pairs.collect do |a, b|
        if a == 1 && b == 1
          1
        else
          0
        end
      end
      Binary.new(result.reverse.join)
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
