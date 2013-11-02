require './lib/memory/data_flip_flop'
require './lib/mux/multiplexer_multibit'

module Memory
  class Register
    attr_accessor :input, :load
    attr_reader :size
    include Helpers::Signals

    def initialize(bit_size, clock)
      @flip_flops = build_flip_flops(bit_size, clock)
      @size = bit_size
    end

    def tick
      puts "Pre-Tick Debug: load(#{load}) input(#{input}) output(#{output})"
      validate_input
      
      # MUX
      #  control = load
      # when control high
      #   f.each{input = input}
      # else
      #   f.each{input = output}
      # mux = Mux::MultiplexerMultibit.new(size)
      # mux.control = lambda{ load }
      # mux.input_a = 

      if load == HIGH
        @data = input
        puts "Ticking the Flip Flops"
        @flip_flops.each{|f| f.tick}
      end
      puts "Post-Tick Debug: load(#{load}) input(#{input}) output(#{output})"
    end

    def output
      Helpers::Binary.from_bits(@flip_flops.collect{|f| f.output})
    end

  private
    def validate_input
      unless input.size == size
        raise ArgumentError.new("Input has the wrong bitsize")
      end
    end

    def build_flip_flops(quantity, clock)
      Array.new(quantity) do |bit| 
        flip = DataFlipFlop.new(clock) 
        flip.input = lambda{ @data.bits[bit] }
        flip
      end.reverse
    end
  end
end