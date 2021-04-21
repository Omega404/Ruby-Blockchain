require './test/test_helper'
require './src/Block.rb'


class Tester < Minitest::Test
  def test_hash
    chainB = Block.new(123,456)
    assert_equal 0, chainB.hash
    assert(chainB.email != nil)
  end
end