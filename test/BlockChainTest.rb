require './test/test_helper'
require './src/blockchain.rb'


class Tester < Minitest::Test
  def test_hash_holamundo
    resultado = Hash0.generarhash("holamundo")
    assert_equal "0ae2cdbabe8eaf0790f4ff52ca1f7bdeb06e5c7b321c438cb659be35c22f8f0c", resultado
  end

  def test_hash_Hola_mundo
    resultado = Hash0.generarhash("Hola mundo")
    assert_equal "0802b10ee2d002691c4a3af3bf5133c4c89f06798655cbbd85da830c6581a5f1", resultado
  end

  def test_blockchain_debe_incializar_con_genesis
    b = Blockchain.instance
    resultado = b.getbloque(0)
    assert_equal 0, resultado.index
    assert_equal "", resultado.email
    assert_equal "", resultado.hashprevio
    assert_equal "", resultado.fecha
    assert_equal Hash.new, resultado.hash
  end

  def test_bloque_genesis
    b = Blockchain.instance
    resultado = b.genesis()
    assert_equal 0, resultado.index
    assert_equal "", resultado.email
    assert_equal "", resultado.hashprevio
    assert_equal "", resultado.fecha
    assert_equal Hash.new, resultado.hash
  end

  def test_bloque_genesis_ingual_bloque0
    b = Blockchain.instance
    resultado = b.getbloque(0)
    resultadogenesis = b.getgenesis
    assert_equal resultado, resultadogenesis
    assert_equal 0,resultadogenesis.index
  end

  def test_generar_bloque1
    b = Blockchain.instance
    b.generarbloque("emailinvetado@pagina.com",Date.strptime('30-08-1998','%d-%m-%Y'))
    bloque1 = b.getbloque(1)
    resultadogenesis = b.getgenesis
    assert_equal bloque1.hashprevio(), resultadogenesis.hash()
    assert_equal Hash.new, bloque1.hashprevio
    assert_equal 1, bloque1.index
  end
  
  def test_generar_bloque2
    b = Blockchain.instance
    b.generarbloque("emailinvetado@pagina.com",Date.strptime('30-08-1998','%d-%m-%Y'))
    b.generarbloque("emailinvetado1@pagina.com",Date.strptime('30-08-1998','%d-%m-%Y'))
    bloque1 = b.getbloque(1)
    bloque2 = b.getbloque(2)
    assert_equal bloque2.hashprevio(), bloque1.hash()
    assert_equal 2, bloque2.index
  end

  def test_generar_JSON
    b = Blockchain.instance
    b.limpiar
    bloque1 = b.generarbloque("emailinvetado@pagina.com",Date.strptime('30-08-1998','%d-%m-%Y'))
    assert_equal "[1,\"emailinvetado@pagina.com\",\"1998-08-30\",{}]", b.generarJson(bloque1)
  end

  def test_mismo_hash
    b = Blockchain.instance
    bloque1 = Block.new(1,"emailinvetado@pagina.com","0",Date.strptime('30-08-1998','%d-%m-%Y'))
    bloque2 = Block.new(1,"emailinvetado@pagina.com","0",Date.strptime('30-08-1998','%d-%m-%Y'))
    assert_equal b.hashear(bloque1), b.hashear(bloque2)
  end

  def test_mismo_hash2
    b = Blockchain.instance
    bloque1 = Block.new(1,".com","0",Date.strptime('30-08-1998','%d-%m-%Y'))
    bloque2 = Block.new(1,".com","0",Date.strptime('30-08-1998','%d-%m-%Y'))
    assert_equal b.hashear(bloque1), b.hashear(bloque2)
  end

  def test_singleton
    b1 = Blockchain.instance
    b2 = Blockchain.instance
    assert_equal b1,b2
    b1.generarbloque("emailinvetado@pagina.com",Date.strptime('30-08-1998','%d-%m-%Y'))
    assert_equal b1.getbloque(1).hash, b2.getbloque(1).hash
  end

  def test_obtener_con_hash
    b = Blockchain.instance
    b.generarbloque("emailinvetado@pagina.com",Date.strptime('30-08-1998','%d-%m-%Y'))
    b.generarbloque("emailinvetado@pagina.com",Date.strptime('30-08-1998','%d-%m-%Y'))
    b.generarbloque("emailinvetado@pagina.com",Date.strptime('30-08-1998','%d-%m-%Y'))
    hash = b.getbloque(2).hash
    assert_equal b.getbloque(2).hash, b.getbloquehash(hash)
  end

  def test_Hash_respecto_fecha
    b = Blockchain.instance
    b.limpiar
    b.generarbloque("emailinvetado@pagina.com",Date.strptime('14-04-2021','%d-%m-%Y'))
    b.generarbloque("emailinvetado@pagina.com",Date.strptime('15-04-2021','%d-%m-%Y'))
    bloque1 = b.getbloque(1)
    bloque2 = b.getbloque(2)
    assert bloque1.hash.start_with?('00')
    assert bloque2.hash.start_with?('0')
  end

  def test_verificar_cadena
    b = Blockchain.instance
    b.generarbloque("emailinvetado1@pagina.com",Date.strptime('27-08-1998','%d-%m-%Y'))
    b.generarbloque("emailinvetado2@pagina.com",Date.strptime('28-08-1998','%d-%m-%Y'))
    b.generarbloque("emailinvetado3@pagina.com",Date.strptime('29-08-1998','%d-%m-%Y'))
    assert_equal true,b.verificacion
  end

  def test_getlast
    b = Blockchain.instance
    refute_nil b.getlast
    assert_nil b.getbloque(b.getlast.index + 1)
  end

  def test_limpiar
    b = Blockchain.instance
    b.generarbloque("emailinvetado@pagina.com",Date.strptime('30-08-1998','%d-%m-%Y'))
    refute_nil b.getbloque(1)
    b.limpiar
    assert_nil b.getbloque(1)
    assert_equal b.getgenesis, b.getlast
  end

  def test_100bloques
    b = Blockchain.instance
    b.limpiar
    f = Date.strptime('01-01-2000','%d-%m-%Y')
    f0 = f
    for i in 1..100
      f = f.next_day(1)
      b.generarbloque("#{i}@pagina.com",f)
    end
    bloque = b.getbloque(50)
    assert_equal bloque.fecha, Date.strptime('20-02-2000','%d-%m-%Y')
    assert_equal true, b.verificacion
    assert_equal bloque.email, "50@pagina.com"
    assert_equal b.getbloque(1).email, "1@pagina.com"
  end
end