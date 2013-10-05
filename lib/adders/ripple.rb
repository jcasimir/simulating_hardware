module Adders
  class Ripple
    attr_accessor :input_a, :input_b
    attr_reader :size

    def initialize(size)

    end

    def output
      Helpers::Binary.new('00000000')
    end
  end
end
