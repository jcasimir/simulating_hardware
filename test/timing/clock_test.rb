require './test/test_helper'
require './lib/timing/clock'

class ClockTest < GateTest
  attr_reader :clock

  def setup
    @clock = Timing::Clock.new
  end

  def test_it_starts_low
    assert_low clock.output
  end

  def test_it_ticks_to_high
    clock.tick
    assert_high clock.output
  end

  def test_it_cycles_back_to_low
    2.times{ clock.tick }
    assert_low clock.output
  end
end