require './lib/helpers/binary'

module Adders
  class ALU
    attr_accessor :zero_x, :negate_x, :input_x
    attr_accessor :zero_y, :negate_y, :input_y

    include Helpers::Signals

    def output_x
      output_negate_x
    end

    def output_zero_x
      if zero_x == HIGH
        sixteen_bit_zero
      else
        input_x
      end
    end

    def output_negate_x
      if negate_x == HIGH
        output_zero_x.inverse
      else
        output_zero_x
      end
    end

    def output_y
      output_negate_y
    end

    def output_negate_y
      if negate_y == HIGH
        output_zero_y.inverse
      else
        output_zero_y
      end
    end

    def output_zero_y
      if zero_y == HIGH
        sixteen_bit_zero
      else
        input_y
      end
    end

  private
    def sixteen_bit_zero
      Helpers::Binary.new("0000 0000 0000 0000")
    end

  end
end