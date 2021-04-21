class Block
    def initialize(index,email,previousBlock,fecha)
        @index = index
        @email = email
        @hashprevio = previousBlock
        @fecha = fecha
    end
    attr_reader :index,:email,:hashprevio,:fecha,:hash
    attr_writer :hash
end
