module Memory
  class Register
    attr_accessor :input, :load
    attr_reader :size
    include Helpers::Signals

    def initialize(bit_size)
      @size = bit_size
    end

    def tick
      validate_input
      if load == HIGH
        @data = input
      end
    end

    def output
      @data
    end

    def validate_input
      unless input.size == size
        raise ArgumentError.new("Input has the wrong bitsize")
      end
    end
  end
end