require './test/test_helper'
require './lib/memory/register'
require './lib/timing/clock_service'

class RegisterTest < GateTest
  attr_reader :register

  def setup
    @clock = Timing::ClockService.new
    @register = Memory::Register.new(16, @clock)
  end

  def test_it_loads_zeros
    register.input = Helpers::Binary.new("0000 0000 0000 0000")
    register.load = HIGH
    register.tick
    expected = Helpers::Binary.new("0000 0000 0000 0000")
    assert_equal expected, register.output
  end

  def test_it_loads_data
    register.input = Helpers::Binary.new("1111 0000 1111 0000")
    register.load = HIGH
    register.tick
    expected = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal expected, register.output
  end

  def test_it_holds_on_to_data
    register.input = Helpers::Binary.new("1111 0000 1111 0000")
    register.load = HIGH
    register.tick
    register.load = LOW
    register.tick
    expected = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal expected, register.output
  end

  def test_it_holds_on_to_data
    puts "Starting the Hold test"
    register.input = Helpers::Binary.new("1111 0000 1111 0000")
    register.load = HIGH
    register.tick
    register.input = Helpers::Binary.new("0000 0000 0000 0000")
    register.load = LOW
    expected = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal expected, register.output
    register.tick
    expected = Helpers::Binary.new("1111 0000 1111 0000")
    assert_equal expected, register.output
  end

  def test_it_only_stores_the_correct_bitsize
    register.input = Helpers::Binary.new("1111 0000")
    register.load = HIGH
    assert_raises ArgumentError do
      register.tick  
    end
  end

end