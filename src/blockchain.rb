require 'digest'
require 'json'
require 'singleton'
require 'date'
require './src/Block.rb'
require './src/Hasher.rb'

class Blockchain
    include Singleton
    def initialize()
        @array = [genesis()]
    end

    def genesis
        block = Block.new(0,"","","")
        block.hash = Hash.new
        block
    end

    def getbloque(indice)
        @array.at(indice)
    end

    def getbloquehash(hash_de_bloque)
        i = 0
        while hash_de_bloque != @array[i].hash
            i+=1
        end
        @array[i]
    end

    def getgenesis
        @array.first
    end

    def getlast
        @array.last
    end

    def generarbloque(email,fecha)
        bloque = Block.new(@array.size,email,@array.last.hash,fecha)
        bloque.hash = hashear(bloque)
        @array.push(bloque)
        bloque
    end
    
    def hashear(bloque)
        texto = generarJson(bloque)
        Hasheador.getstrategy(bloque.fecha.mday,texto)
    end

    def generarJson(bloque)
        datos = [bloque.index,bloque.email,bloque.fecha,bloque.hashprevio]
        datos.to_json
    end
    
    def limpiar
        @array = [genesis()]
    end

    def verificacion
        estado = true
        lista = []
        if @array[0].hash != Hash.new or @array[0].hashprevio != ""
            estado = false
        end
        for i in 1..@array.last.index
            if @array[i].hashprevio != @array[i-1].hash or @array[i].hash != hashear(@array[i])
                estado = false
            end
        end
        estado
    end
end