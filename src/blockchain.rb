require 'digest'
require 'json'
require 'singleton'
require 'date'
require './src/Block.rb'
require './src/Hasher.rb'

class Blockchain
    include Singleton
    def initialize()    #constructor
        @array = [genesis()]
    end

    def genesis         #genera un bloque vacio al inicio de la cadena
        block = Block.new(0,"","","","","")
        block.hash = Hash.new
        block
    end

    def getbloque(indice)   #devuelve un bloque en base al indice recibido
        @array.at(indice)
    end

    def getbloquehash(hash_de_bloque)   #devuelve un bloque en base al hash
        i = 0
        while hash_de_bloque != @array[i].hash
            i+=1
        end
        @array[i]
    end

    def getgenesis          #devuelve el primer bloque
        @array.first
    end

    def getlast             #devuelve el ultimo bloque
        @array.last
    end

    def generarbloque(email,mot,doc)    #crea un bloque a traves de los datos recibidos,obteniendo el hash del ultimo bloque y generando la fecha el hash propio
        fecha = Date.today
        bloque = Block.new(@array.size,email,mot,doc,@array.last.hash,fecha)
        bloque.hash = hashear(bloque)
        @array.push(bloque)
        bloque
    end
    
    def hashear(bloque)                 #convierte el string devuelto por generarJson y lo manda al Hasheador para determinar la cantidad de ceros
        texto = generarJson(bloque)
        Hasheador.getstrategy(bloque.fecha.mday,texto)
    end

    def generarJson(bloque)             #convierte los atributos del bloque en un string para generar un hash
        datos = [bloque.index,bloque.email,bloque.motivo,bloque.archivo,bloque.fecha,bloque.hashprevio]
        datos = JSON.generate(datos)
        datos
    end

    def generarJsonHash(bloque)         #convierte todos los atributos del bloque en un string
        datos = [bloque.index,bloque.email,bloque.motivo,bloque.archivo,bloque.fecha,bloque.hashprevio,bloque.hash]
        datos = JSON.generate(datos)
        datos
    end
    
    def limpiar                         #elimina todo el array y genera un nuevo bloque genesis
        @array = [genesis()]
    end

    def verificacion                    # verifica que el hashanterior sea igual al hash del bloque anterior
        estado = true                   # y que el hash que posea el bloque actual sea igual al hash generado con su datos
        lista = []
        if @array[0].hash != Hash.new or @array[0].hashprevio != ""
            estado = false
        end
        for i in 1..@array.last.index
            if @array[i].hashprevio != @array[i-1].hash or @array[i].hash != hashear(@array[i])
                estado = false
            end
        end
        estado
    end

    def guardar_cadena                  #genera un archivo con todos los atributos de los bloques de la cadena
        archivo = File.open("cadena.txt","w")
        for i in 1..@array.last.index
            datos = generarJsonHash(@array[i])
            archivo.puts datos
        end
        archivo.close
        archivo
    end
end