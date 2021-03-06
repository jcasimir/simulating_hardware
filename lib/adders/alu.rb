require './lib/helpers/binary'
require './lib/adders/ripple'
require './lib/gates/and_multibit'
require './lib/gates/inverter'
require './lib/mux/multiplexer_multibit'

module Adders
  class ALU
    include Helpers::Signals

    def self.input_pins
     [:zero_x, :negate_x, :input_x,
      :zero_y, :negate_y, :input_y,
      :function, :negate_out]
    end

    attr_writer *input_pins

    input_pins.each do |pin|
      define_method pin do
        lambda{ instance_variable_get("@#{pin}") }  
      end
    end

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
      gates_for_output_zero_x.output
    end

    def gates_for_output_zero_x
      @gates_for_output_zero_x ||= Mux::MultiplexerMultibit.new(16).tap do |mux|
        mux.input_a = input_x
        mux.input_b = sixteen_bit_zero
        mux.control = zero_x
      end
    end

    def output_negate_x
      gates_for_output_negate_x.output
    end

    def gates_for_output_negate_x
      @gates_for_output_negate_x ||= Mux::MultiplexerMultibit.new(16).tap do |mux|
        inverter = Gates::Inverter.new(16)
        inverter.input = output_zero_x

        mux.input_a = output_zero_x
        mux.input_b = inverter.output
        mux.control = negate_x
      end
    end

    def output_y
      output_negate_y
    end

    def output_negate_y
      gates_for_output_negate_y.output
    end

    def gates_for_output_negate_y
      @gates_for_output_negate_y ||= Mux::MultiplexerMultibit.new(16).tap do |mux|
        inverter = Gates::Inverter.new(16)
        inverter.input = output_zero_y

        mux.input_a = output_zero_y
        mux.input_b = inverter.output
        mux.control = negate_y
      end
    end

    def output_zero_y
      gates_for_output_zero_y.output
    end

    def gates_for_output_zero_y
      @gates_for_output_zero_y ||= Mux::MultiplexerMultibit.new(16).tap do |mux|
        mux.input_a = input_y
        mux.input_b = sixteen_bit_zero
        mux.control = zero_y
      end
    end

    def output_function
      gates_for_output_function.output
    end

    def gates_for_output_function
      @gates_for_output_function ||= Mux::MultiplexerMultibit.new(16).tap do |mux|
        mux.input_a = gates_for_output_x_and_output_y.output
        mux.input_b = gates_for_output_x_plus_output_y.output
        mux.control = function
      end
    end

    def gates_for_output_x_plus_output_y
      @gates_for_output_x_plus_output_y ||= Adders::Ripple.new(16).tap do |adder|
        adder.input_a = output_x
        adder.input_b = output_y
      end
    end

    def gates_for_output_x_and_output_y
      @gates_for_output_x_and_output_y ||= Gates::AndMultibit.new(16).tap do |ander|
        ander.input_a = output_x
        ander.input_b = output_y
      end
    end

    def output_negate_out
      gates_for_negate_out.output
    end

    def gates_for_negate_out
      @gates_for_negate_out ||= Mux::MultiplexerMultibit.new(16).tap do |mux|
        inverter = Gates::Inverter.new(16)
        inverter.input = output_function
        
        mux.input_a = output_function
        mux.input_b = inverter.output
        mux.control = negate_out
        mux.output
      end
    end
  end
end
