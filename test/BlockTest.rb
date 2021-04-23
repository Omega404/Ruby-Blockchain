require './test/test_helper'
require './src/Block.rb'


class Tester < Minitest::Test
  def test_Block_should_exist
    bloque = Block.new(1,23,45,67,89,Date.today)
    refute_nil bloque
  end

  def test_Hash_setter_should_change_the_hash_value
    bloque = Block.new(1,23,45,67,89,Date.today)
    assert_nil bloque.hash
    bloque.hash = "0"
    refute_nil bloque.hash
    assert_equal "0", bloque.hash
  end
end