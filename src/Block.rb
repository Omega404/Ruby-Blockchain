class Block
    def initialize(index,email,previousBlock,fecha,hash)
        @index = index
        @email = email
        @hashprevio = previousBlock
        @fecha = fecha
        @hash = hash
    end
    attr_reader :index,:email,:hashprevio,:fecha,:hash
end
