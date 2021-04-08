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

  def test_blockchain_debe_incializar_con_genesis
    b = Blockchain.new()
    resultado = b.getbloque(0)
    assert_equal 0, resultado.index
    assert_equal "", resultado.email
    assert_equal "", resultado.hashprevio
    assert_equal "", resultado.fecha
    assert_equal "abc", resultado.hash
  end

  def test_bloque_genesis
    b = Blockchain.new()
    resultado = b.genesis()
    assert_equal 0, resultado.index
    assert_equal "", resultado.email
    assert_equal "", resultado.hashprevio
    assert_equal "", resultado.fecha
    assert_equal "abc", resultado.hash
  end

  def test_bloque_genesis_ingual_bloque0
    b = Blockchain.new()
    resultado = b.getbloque(0)
    resultadogenesis = b.getgenesis
    assert_equal resultado, resultadogenesis
    assert_equal 0,resultadogenesis.index
  end

  def test_generar_bloque1
    b = Blockchain.new()
    b.generarbloque("emailinvetado@pagina.com","30/08/1998","hash")
    bloque1 = b.getbloque(1)
    resultadogenesis = b.getgenesis
    assert_equal bloque1.hashprevio(), resultadogenesis.hash()
    assert_equal "abc",bloque1.hashprevio()
    assert_equal 1, bloque1.index()
  end
  
  def test_generar_bloque2
    b = Blockchain.new()
    b.generarbloque("emailinvetado@pagina.com","30/08/1998","hash")
    b.generarbloque("emailinvetado1@pagina.com","31/08/1998","hash1")
    bloque1 = b.getbloque(1)
    bloque2 = b.getbloque(2)
    assert_equal bloque2.hashprevio(), bloque1.hash()
    assert_equal "hash",bloque2.hashprevio()
    assert_equal 2, bloque2.index()
  end
end