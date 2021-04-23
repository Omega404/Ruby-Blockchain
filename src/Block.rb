class Block
    def initialize(index,email,doc,mot,previousBlock,fecha)
        @index = index
        @email = email
        @archivo = doc
        @motivo = mot
        @hashprevio = previousBlock
        @fecha = fecha
    end
    attr_reader :index,:email,:motivo,:archivo,:hashprevio,:fecha,:hash
    attr_writer :hash
end
