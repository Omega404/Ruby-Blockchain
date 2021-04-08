require 'digest'
require './src/Block.rb'

class Blockchain
    def initialize()
        @array = [genesis()]
    end
    def hashear(texto)
        Digest::SHA256.hexdigest texto
    end
    def genesis
        block = Block.new(0,"","","","abc")
        return block
    end
    def getbloque(indice)
        @array.at(indice)
    end
    def getgenesis
        @array.first
    end
    def generarbloque(email,fecha,hash)
        #hash = @array.size + emailt.to_s + fecha.to_s + hash.to_s + @array.last.hash.to_s
        @array.push(Block.new(@array.size,email,@array.last.hash,fecha,hash))
    end
end