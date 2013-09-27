require './test/test_helper'
require './lib/gates/not'

class NotGateTest < GateTest
  def gate
    @gate ||= Gates::Not.new
  end

  def test_it_is_high_when_the_input_is_low
    gate.input = LOW
    assert_high gate.output
  end

  def test_it_is_low_when_the_input_is_high
    gate.input = HIGH
    assert_low gate.output
  end
end
