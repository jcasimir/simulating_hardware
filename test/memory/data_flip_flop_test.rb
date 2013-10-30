require './test/test_helper'
require './lib/memory/data_flip_flop'
require './lib/timing/clock_service'

class DataFlipFlopTest < GateTest
  attr_reader :flip, :clock

  def setup
    @clock = Timing::ClockService.new
    @flip = Memory::DataFlipFlop.new(@clock)
  end

  def test_it_exists
    assert Memory::DataFlipFlop
  end

  def test_it_outputs_high_with_a_constant_high_input
    flip.input = HIGH
    clock.tick
    assert_high flip.output
  end

  def test_it_outputs_low_with_a_constant_low_input
    flip.input = LOW
    clock.tick
    assert_low flip.output
  end

  def test_it_outputs_high_from_the_last_cycle_after_input_change
    flip.input = HIGH
    clock.tick
    flip.input = LOW
    assert_high flip.output
  end

  def test_it_outputs_low_from_the_last_cycle_after_input_change
    flip.input = LOW
    clock.tick
    flip.input = HIGH
    assert_low flip.output
  end

  def test_it_cycles_through_inputs_across_clock_cycles
    flip.input = LOW
    clock.tick
    flip.input = HIGH
    assert_low flip.output
    clock.tick
    flip.input = LOW
    assert_high flip.output
    clock.tick
    assert_low flip.output
  end
end