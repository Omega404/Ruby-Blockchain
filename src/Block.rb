class Block
    def initialize(email,previousBlock)
        @email = email
        @pBlock = previousBlock
        @hush = 0 #posteriormente se generara con la funcion digest
    end
    def hush
        @hush
    end
end