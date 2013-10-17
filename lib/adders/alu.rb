require './lib/helpers/binary'

module Adders
  class ALU
    attr_accessor :zero_x, :negate_x, :input_x

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

  private
    def sixteen_bit_zero
      Helpers::Binary.new("0000 0000 0000 0000")
    end


    # def output_negate_x
    #   if negate_x && output_zero_x
    #     LOW
    #   elsif negate_x
    #     HIGH
    #   else
    #     output_zero_x
    #   end
    # end
  end
end