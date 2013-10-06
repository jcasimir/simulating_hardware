require 'bundler'
Bundler.require
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/helpers/signals'

class GateTest < Minitest::Test

  include Helpers::Signals

  def assert_high(pin)
    assert_equal HIGH, pin
  end

  def assert_low(pin)
    assert_equal LOW, pin
  end
end