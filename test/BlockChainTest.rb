require 'minitest/autorun'
require './src/blockchain.rb'


class Tester < Minitest::Test
  def test_hash_holamundo
    b = Blockchain.new()
    resultado = b.hashear("holamundo")
    assert_equal "93fa3e4624676f2e9aa143911118b4547087e9b6e0b6076f2e1027d7a2da2b0a", resultado
  end
  def test_hash_Hola_mundo
    b = Blockchain.new()
    resultado = b.hashear("Hola mundo")
    assert_equal "ca8f60b2cc7f05837d98b208b57fb6481553fc5f1219d59618fd025002a66f5c", resultado
  end
end