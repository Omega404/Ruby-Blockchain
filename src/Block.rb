require 'digest'

class Block
    def initialize(index,email,previousBlock,fecha,hash)
        @index = 0
        @email = email
        @pBlock = previousBlock
        @fecha = fecha
        @hash = hash
    end
    def index
        @index
    end
    def hashprevio
        @pBlock
    end
    def hash
        @hash
    end
    def email
        @email
    end
    def fecha
        @fecha
    end
end

#93fa3e4624676f2e9aa143911118b4547087e9b6e0b6076f2e1027d7a2da2b0a
#0b894166d3336435c800bea36ff21b29eaa801a52f584c006c49289a0dcf6e2f
#ca8f60b2cc7f05837d98b208b57fb6481553fc5f1219d59618fd025002a66f5c
