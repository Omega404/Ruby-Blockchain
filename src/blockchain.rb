require 'digest'
require './src/Block.rb'

class Blockchain
    def hashear(texto)
        Digest::SHA256.hexdigest texto
    end
    def genesis
        block = Block.new(0,"","","","abc")
        return block
    end
    def getbloque(indice)
        genesis()
    end
end