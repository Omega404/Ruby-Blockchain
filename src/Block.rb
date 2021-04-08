require 'digest'

class Block
    def initialize(index,email,previousBlock,fecha,hash)
        @index = index
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
