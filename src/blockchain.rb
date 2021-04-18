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
        @fecha
    end

    def hashear(texto)
        Hasheador.getstrategy(@fecha,texto)
    end

    def genesis
        block = Block.new(0,"","","",Hash.new)
        return block
    end

    def getbloque(indice)
        @array.at(indice)
    end

    def getbloquehash(hash_de_bloque)
        i = 0
        while hash_de_bloque != @array[i].hash
            i+=1
        end
        @array[i].hash
    end

    def getgenesis
        @array.first
    end

    def getlast
        @array.last
    end

    def generarbloque(email,fecha)
        @fecha = fecha.mday
        hash = hashear(generarJson(@array.size,email,fecha,@array.last.hash))
        @array.push(Block.new(@array.size,email,@array.last.hash,fecha,hash))
    end

    def generarJson(index,email,fecha,hashprevio)
        datos = [index,email,fecha,hashprevio]
        datos.to_json
    end
    
    def limpiar
        @array = [genesis()]
    end

    def verificacion
        estado = true
        lista = []
        if @array[0].hash != Hash.new or @array[0].hashprevio != ""
            puts 'se activo el hash 0'
            estado = false
        end
        for i in 1..@array.last.index
            if i != 0
                if @array[i].hashprevio != @array[i-1].hash or @array[i].hash != Hasheador.getstrategy(@array[i].fecha.mday,generarJson(@array[i].index,@array[i].email,@array[i].fecha,@array[i-1].hash))
                    p @array[i]
                    puts "hash:#{@array[i].hash} hash generado#{hashear(generarJson(@array[i].index,@array[i].email,@array[i].fecha,@array[i].hashprevio))}"
                    p @array[i-1]
                    estado = false
                end
            end
        end
        estado
    end
end

b = Blockchain.instance
b.generarbloque("emailinvetado@pagina.com",Date.strptime('14-04-2021','%d-%m-%Y'))