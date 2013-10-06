require './lib/helpers/signals'
require './lib/adders/full'

module Adders
  class Incrementer
    attr_accessor :input

    def initialize(bits)

    end

    def output
      Helpers::Binary.new("0000 0001")
    end

  end
end