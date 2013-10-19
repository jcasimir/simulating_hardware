require './lib/helpers/binary'
require './lib/adders/ripple'
require './lib/gates/and_multibit'
require './lib/mux/one_bit_multiplexer'

module Adders
  class ALU
    attr_accessor :zero_x, :negate_x, :input_x
    attr_accessor :zero_y, :negate_y, :input_y
    attr_accessor :function, :negate_out

    include Helpers::Signals

    def output
      output_negate_out
    end

  private
    def sixteen_bit_zero
      Helpers::Binary.new("0000 0000 0000 0000")
    end

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

    def output_function
      # mux = OneBitMultiplexer.new
      # mux.input_a = output_x_and_output_y.output
      # mux.input_b = output_x_plus_output_y
      # mux.control = function
      # mux.output
      if function == HIGH
        output_x_plus_output_y.output
      else
        output_x_and_output_y.output        
      end
    end

    def output_x_plus_output_y
      adder = Adders::Ripple.new(16)
      adder.input_a = output_x
      adder.input_b = output_y
      adder
    end

    def output_x_and_output_y
      @ander_output_x_and_output_y ||= ander_output_x_output_y
    end

    def ander_output_x_output_y
      ander = Gates::AndMultibit.new(16)
      ander.input_a = output_x
      ander.input_b = output_y
      ander
    end

    def output_negate_out
      if negate_out == HIGH
        output_function.inverse
      else
        output_function
      end
    end
  end
end

# def adder
#   @adder ||= Adders::Ripple.new(16)
# end

# def output_function
#   if function == HIGH
#     adder.input_a = output_x
#     adder.input_b = output_y
#     adder.output
#   else
#     output_x & output_y
#   end
# end