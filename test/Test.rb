require 'minitest/autorun'
require './src/Block.rb'


class Tester < Minitest::Test
  def test_hush
    chainB = Block.new(123,456)
    assert_equal 0, chainB.hush
  end
  def test_email
    chainB = Block.new(123,456)
    assert(chainB.email != nil)
  end
end