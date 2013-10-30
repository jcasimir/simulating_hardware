require './lib/timing/clock'

module Timing
  class ClockService
    attr_reader :subscribers, :clock

    def initialize
      @subscribers = []
      @clock = Clock.new
    end

    def add_subscriber(listener)
      @subscribers << listener
    end

    def subscriber_count
      subscribers.count
    end

    def tick
      state = clock.tick
      subscribers.each{|s| s.tick}
      return state
    end
  end
end