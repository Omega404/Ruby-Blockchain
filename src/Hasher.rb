require 'digest'
require 'minitest/autorun'

module Hasheador
    def self.getstrategy(fecha,texto)
        if fecha % 2 == 0
            Hash00.generarhash(texto)
        else
            Hash0.generarhash(texto)
        end
    end
end

module Hash0
    def self.generarhash(texto)
        hash = texto
        until hash.start_with?('0')
            hash = Digest::SHA256.hexdigest hash
        end
        hash
    end
end

module Hash00
    def self.generarhash(texto)
        hash = texto
        until hash.start_with?('00')
            hash = Digest::SHA256.hexdigest hash 
        end
        hash
    end
end