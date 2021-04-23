require './test/test_helper'
require './src/blockchain.rb'
require './src/Hasher.rb'


class Tester < Minitest::Test
  def test_hash0_holamundo_should_be_equal_to_0ae2cdbabe8eaf0790f4ff52ca1f7bdeb06e5c7b321c438cb659be35c22f8f0c
    resultado = Hash0.generarhash("holamundo")
    assert_equal "0ae2cdbabe8eaf0790f4ff52ca1f7bdeb06e5c7b321c438cb659be35c22f8f0c", resultado
  end

  def test_hash0_Hola_mundo_should_be_equal_to_0802b10ee2d002691c4a3af3bf5133c4c89f06798655cbbd85da830c6581a5f1
    resultado = Hash0.generarhash("Hola mundo")
    assert_equal "0802b10ee2d002691c4a3af3bf5133c4c89f06798655cbbd85da830c6581a5f1", resultado
  end

  def test_blockchain_first_block_should_be_genesis
    b = Blockchain.instance
    resultado = b.getgenesis()
    assert_equal resultado, b.getbloque(0) 
  end

  def test_bloque_genesis_should_be_empty
    b = Blockchain.instance
    resultado = b.genesis()
    assert_equal 0, resultado.index
    assert_equal "", resultado.email
    assert_equal "", resultado.archivo
    assert_equal "", resultado.motivo
    assert_equal "", resultado.hashprevio
    assert_equal "", resultado.fecha
    assert_equal Hash.new, resultado.hash
  end

  def test_bloque_genesis_should_be_equal_to_bloque0
    b = Blockchain.instance
    resultado = b.getbloque(0)
    resultadogenesis = b.getgenesis
    assert_equal resultado, resultadogenesis
    assert_equal 0,resultadogenesis.index
  end

  def test_generarbloque_bloque1Hashprevio_should_be_Equal_to_bloquegenesis_hash
    b = Blockchain.instance
    b.generarbloque("emailinvetado@pagina.com","documento.pdf","motivo")
    bloque1 = b.getbloque(1)
    resultadogenesis = b.getgenesis
    assert_equal bloque1.hashprevio(), resultadogenesis.hash()
    assert_equal Hash.new, bloque1.hashprevio
    assert_equal 1, bloque1.index
  end
  
  def test_generarbloque_bloque2Hashprevio_should_be_Equal_to_bloque1_hash
    b = Blockchain.instance
    b.generarbloque("emailinvetado@pagina.com","documento.pdf","motivo")
    b.generarbloque("emailinvetado1@pagina.com","documento.pdf","motivo")
    bloque1 = b.getbloque(1)
    bloque2 = b.getbloque(2)
    assert_equal bloque2.hashprevio(), bloque1.hash()
    assert_equal 1, bloque1.index
    assert_equal 2, bloque2.index
  end

  def test_generarJson_should_generate_generateJSONWithBlockAtributes
    b = Blockchain.instance
    b.limpiar
    bloque1 = b.generarbloque("emailinvetado@pagina.com","documento.pdf","motivo")
    assert_equal "[1,\"emailinvetado@pagina.com\",\"motivo\",\"documento.pdf\",\"2021-04-23\",{}]", b.generarJson(bloque1)
  end

  def test_generarJsonHash_should_generateJSONWithBlockAtributesIncludingHash
    b = Blockchain.instance
    b.limpiar
    bloque = b.generarbloque("emailinvetado@pagina.com","documento.pdf","motivo")
    t = "[1,\"emailinvetado@pagina.com\",\"motivo\",\"documento.pdf\",\"2021-04-23\",{}]"
    t.insert(-2,",\""+b.hashear(bloque)+"\"")   #Debido al cambio constante del atributo "tiempo", requiero generar el hash y concatenarlo al texto de prueba
    assert_equal t, b.generarJsonHash(bloque)
  end

  def test_block_with_same_atributtes_should_have_an_equal_hash
    b = Blockchain.instance
    bloque1 = Block.new(1,"emailinvetado@pagina.com","documento.pdf","motivo","0",Date.strptime('30-08-1998','%d-%m-%Y'))
    bloque2 = Block.new(1,"emailinvetado@pagina.com","documento.pdf","motivo","0",Date.strptime('30-08-1998','%d-%m-%Y'))
    assert_equal b.hashear(bloque1), b.hashear(bloque2)
  end

  def test_hash_getstrategy_Should_beEqualto_LastBlockHash
    b = Blockchain.instance
    b.limpiar
    bloque = b.generarbloque("emailinvetado@pagina.com","documento.pdf","motivo")
    texto = b.generarJson(bloque)
    assert_equal b.getlast.hash, Hasheador.getstrategy(bloque.fecha.day,texto)
  end

  def test_singleton_expect_Only_one_Instance_Of_BlockCahin
    b1 = Blockchain.instance
    b2 = Blockchain.instance
    assert_equal b1,b2
    b1.generarbloque("emailinvetado@pagina.com","documento.pdf","motivo")
    assert_equal b1.getbloque(1).hash, b2.getbloque(1).hash
  end

  def test_getbloquehash_should_return_the_same_block_as_getbloque
    b = Blockchain.instance
    b.generarbloque("emailinvetado@pagina.com","documento.pdf","motivo")
    b.generarbloque("emailinvetado@pagina.com","documento.pdf","motivo")
    b.generarbloque("emailinvetado@pagina.com","documento.pdf","motivo")
    hash = b.getbloque(2).hash
    bloque = b.getbloquehash(hash)
    assert_equal bloque.index, 2
  end

  def test_generarhash_Hash_Should_Start_With_0
    b = Blockchain.instance
    b.limpiar
    bloque = b.generarbloque("emailinvetado@pagina.com","documento.pdf","motivo")
    texto = b.generarJson(bloque)
    assert Hash0.generarhash(texto).start_with?('0')
  end

  def test_generarhash_Hash_Should_Start_With_00
    b = Blockchain.instance
    b.limpiar
    bloque = b.generarbloque("emailinvetado@pagina.com","documento.pdf","motivo")
    texto = b.generarJson(bloque)
    assert Hash00.generarhash(texto).start_with?('00')
  end

  def test_verificacion_should_return_True
    b = Blockchain.instance
    b.generarbloque("emailinvetado1@pagina.com","documento.pdf","motivo")
    b.generarbloque("emailinvetado2@pagina.com","documento.pdf","motivo")
    b.generarbloque("emailinvetado3@pagina.com","documento.pdf","motivo")
    assert_equal true,b.verificacion
  end

  def test_getlast_should_be_the_last_block
    b = Blockchain.instance
    refute_nil b.getlast
    assert_nil b.getbloque(b.getlast.index + 1)
  end

  def test_limpiar_genesis__should__beTheOnlyBlock
    b = Blockchain.instance
    b.generarbloque("emailinvetado@pagina.com","documento.pdf","motivo")
    refute_nil b.getbloque(1)
    b.limpiar
    assert_nil b.getbloque(1)
    assert_equal b.getgenesis, b.getlast
  end

  def test_should_Generate_A_Chain_With_100_Blocks_and_Verificar_should_ReturnTrue
    b = Blockchain.instance
    b.limpiar
    for i in 1..100
      b.generarbloque("#{i}@pagina.com","documento#{i}.pdf","motivo")
    end
    bloque = b.getbloque(50)
    assert_equal bloque.fecha, Date.today
    assert_equal true, b.verificacion
  end

  def test_100_block_chain_1st_50th_and_last_block_comparisons__should_be__true
    b = Blockchain.instance
    b.limpiar
    for i in 1..100
      b.generarbloque("#{i}@pagina.com","documento#{i}.pdf","motivo")
    end
    bloque = b.getbloque(50)
    assert_equal bloque.fecha, Date.today
    assert_equal bloque.archivo, "documento50.pdf"
    assert_equal b.getbloque(1).email, "1@pagina.com"
    assert_equal b.getlast.index, 100
  end

  def test_guardar_cadena__should__Generate_a_file
    b = Blockchain.instance
    b.limpiar
    for i in 1..10
      b.generarbloque("#{i}@pagina.com","documento#{i}.pdf","motivo")
    end
    b.guardar_cadena
    refute_nil File.exist?("cadena.txt")
  end

  def test_guardar_cadena_file__Should_Not__beEmpty
    b = Blockchain.instance
    b.limpiar
    for i in 1..10
      b.generarbloque("#{i}@pagina.com","documento#{i}.pdf","motivo")
    end
    b.guardar_cadena
    refute_nil File.exist?("cadena.txt")
  end
end