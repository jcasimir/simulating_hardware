require './lib/helpers/binary'
require './lib/adders/ripple'
require './lib/gates/and_multibit'
require './lib/gates/inverter'
require './lib/mux/multiplexer_multibit'

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
      mux = Mux::MultiplexerMultibit.new(16)
      mux.input_a = input_x
      mux.input_b = sixteen_bit_zero
      mux.control = zero_x
      mux.output
    end

    def output_negate_x
      if negate_x == HIGH
        inverter = Gates::Inverter.new(16)
        inverter.input = output_zero_x
        inverter.output
      else
        output_zero_x
      end
    end

    def output_y
      output_negate_y
    end

    def output_negate_y
      if negate_y == HIGH
        inverter = Gates::Inverter.new(16)
        inverter.input = output_zero_y
        inverter.output
      else
        output_zero_y
      end
    end

    def output_zero_y
      mux = Mux::MultiplexerMultibit.new(16)
      mux.input_a = input_y
      mux.input_b = sixteen_bit_zero
      mux.control = zero_y
      mux.output
    end

    def output_function
      mux = Mux::MultiplexerMultibit.new(16)
      mux.input_a = output_x_and_output_y.output
      mux.input_b = output_x_plus_output_y.output
      mux.control = function
      mux.output
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
      inverter = Gates::Inverter.new(16)
      inverter.input = output_function

      mux = Mux::MultiplexerMultibit.new(16)
      mux.input_a = output_function
      mux.input_b = inverter.output
      mux.control = negate_out
      mux.output
    end
  end
end
