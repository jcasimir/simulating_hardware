require './lib/signals'

class Nor
  attr_accessor :input_a, :input_b

  include Hardware::Signals

  def output
    (input_b + input_a == LOW) ? HIGH : LOW
  end
end
