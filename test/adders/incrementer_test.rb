require './test/test_helper'
require './lib/adders/incrementer'

class IncrementerTest < GateTest
  def incrementer
    @incrementer ||= Adders::Incrementer.new(4)
  end

  def test_it_increments_zero_to_one
    incrementer.input = Helpers::Binary.new('0000')
    assert_equal Helpers::Binary.new('0001'), incrementer.output
  end

  def test_it_overflows_without_complaint
    incrementer.input = Helpers::Binary.new('1111')
    assert_equal Helpers::Binary.new('0000'), incrementer.output
  end
end