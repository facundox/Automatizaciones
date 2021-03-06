# Clase que se utiliza para dar de alta un nuevo documento GEDO del tipo importado#
  require 'watir-webdriver'
  require '../constantes.rb'
  require './documento.rb'

  class DocumentoImportado < Documento
    def parseJSON()
      archivoDatosGEDO = open("../JSON/documentoImportado.json")
      datosGEDO = archivoDatosGEDO.read
      datosGEDOParseo = JSON.parse(datosGEDO)
      self.parseJSONGenerico(datosGEDOParseo)
      self.parseJSONIMPORTADO(datosGEDOParseo)
    end
    # constructor
    def producirDocumento()
      # Cada documento debe implementar su manera de confeccionar
      self.completarReferencia(self.getReferencia())
      self.importarArchivo()
      self.parsearBotonesProducirDocumento()
    end
    def completarReferencia(referencia)
      # Se aguarda que cargue correctamente la pantalla de Producir documento
      claseCampoTexto = 'z-bandbox-inp'
      self.getElementosHTMLFactory().getElemento('input').esperarMientrasExistaComponente(claseCampoTexto)
      # Se completa la referencia
      # Obtener todos los inputs text y filtar los que no son visible
      # Completa todos los campos que existen
      indice = 0
      claseCampoTextoZ = 'z-textbox'
      cajasDeTexto = self.getElementosHTMLFactory().getElemento('input').obtenerInputsPorClase(claseCampoTextoZ)      
      cajasDeTexto.each do |i|
        indice = indice + 1
        if i.visible?
          if indice == POSICIONREFERENCIA 
            i.set referencia
          #else
            #if indice > POSICIONREFERENCIA
            #  i.set TEXTOCAMPOSFC
            #end  
          end
          i.fire_event :blur
        end
      end
    end
  end
###############################################################################