require 'digest'

class Blockchain
    def hashear(texto)
        Digest::SHA256.hexdigest texto
    end
end