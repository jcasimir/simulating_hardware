require './test/test_helper'
require './lib/timing/clock_service'

class ClockServiceTest < GateTest
  attr_reader :clock

  def setup
    @clock = Timing::ClockService.new
  end

  class FakeListener
    attr_reader :tick_count

    def initialize
      @tick_count = 0
    end

    def tick
      @tick_count += 1
    end
  end

  def test_it_takes_subscribers
    listener = FakeListener.new
    clock.add_subscriber(listener)
    assert_equal 1, clock.subscriber_count
  end

  def test_it_notifies_subscribers_to_clock_change
    listener = FakeListener.new
    clock.add_subscriber(listener)
    5.times{ clock.tick }
    assert_equal 5, listener.tick_count
  end
end