# Reglas para generar HTML, PostScript y PDF de usuario_adJ
# Basadas en infraestructura de dominio público de repasa 
#   (http://structio.sourceforge.net/repasa)

include Make.inc

# Variables requeridas por comdocbook.mak

EXT_DOCBOOK=xdbk

FUENTESDB=introduccion.xdbk instalacion.xdbk paquetesyportes.xdbk interprete-de-ordenes.xdbk conf-basicos.xdbk conf-programas.xdbk conf-dispositivos.xdbk duales.xdbk paquetes-adJ.xdbk openbsdsrc/tabcompose.xdbk novedades.xdbk biblio.xdbk 

SOURCES=$(PROYECTO).$(EXT_DOCBOOK)  $(FUENTESDB)
# Listado de fuentes XML. Preferiblmente en el orden de inclusión.

IMAGES=img/toncliej.png img/fluxbox-xfig.png img/home.png img/prev.png img/toc-minus.png img/blank.png img/important.png img/toc-plus.png img/caution.png img/next.png img/tip.png img/up.png img/draft.png img/note.png img/toc-blank.png img/warning.png img/instala1.png img/instala2.png img/instala3.png img/instala4.png img/instala5.png img/instala5-usb.png img/instala6.png img/ejlatex.png img/xiphos.png img/gimp.png img/inkscape.png img/insadJ1.png img/insadJ1.png img/insadJ2.png img/insadJ3.png img/insadJ4.png img/insadJ5.png img/insadJ6.png img/insadJ7.png img/audacious.png img/audacity.png img/gnumeric.png
# Listado de imagenes, preferiblemente en formato PNG

HTML_DIR=html
# Directorio en el que se generará información en HTML (con reglas por defecto)

HTML_TARGET=$(HTML_DIR)/index.html
# Nombre del HTML principal (debe coincidir con el especificado en estilohtml.xsl)

XSLT_HTML=estilohtml.xsl
# Hoja XSLT para generar HTML con regla por defecto

PRINT_DIR=imp
# Directorio en el que se genera PostScript y PDF en reglas por defecto

DSSSL_PRINT=estilo.dsl\#print
# Hoja de estilo DSSSL para generar TeX en reglas por defecto

DSSSL_HTML=estilo.dsl\#html
# Hoja de estilo DSSSL para generar HTML en reglas por defecto
#
OTHER_HTML=

PRECVS=guias/

INDEX=indice.$(EXT_DOCBOOK)
# Si habrá un índice, nombre del archivo con el que debe generarse (incluirlo al final del documento).


# Variables requeridas por comdist.mk

GENDIST=Derechos.txt $(SOURCES) $(IMAGES)
# Dependencias por cumplir antes de generar distribución

ACTHOST=git@github.com:pasosdeJesus/
# Sitio en Internet donde actualizar. Método indicado por $(ACT_PROC) de confv.sh

ACTDIR=usuario_adJ
# Directorio en $(ACTHOST) por actualizar

#USER=$(LOGNAME),structio
# Usuario en $(ACTHOST).  Si es el mismo que en la máquina local comentar.

GENACT=ghtodo $(PROYECTO)-$(PRY_VERSION)_html.tar.gz #$(PRINT_DIR)/$(PROYECTO)-$(PRY_VERSION).ps.gz $(PRINT_DIR)/$(PROYECTO)-$(PRY_VERSION).pdf 
# Dependencias por cumplir antes de actualizar sitio en Internet al publicar

FILESACT=$(PROYECTO)-$(PRY_VERSION).tar.gz $(PROYECTO)-$(PRY_VERSION)_html.tar.gz $(HTML_DIR)/* #$(PRINT_DIR)/$(PROYECTO)-$(PRY_VERSION).ps.gz $(PRINT_DIR)/$(PROYECTO)-$(PRY_VERSION).pdf 
# Archivos que se debe actualizar en sitio de Internet cuando se publica

all: $(HTML_TARGET) #$(PRINT_DIR)/$(PROYECTO).ps $(PRINT_DIR)/$(PROYECTO).pdf

cvstodo: distcvs 
	rm -rf $(PROYECTO)-$(PRY_VERSION)
	tar xvfz $(PROYECTO)-$(PRY_VERSION).tar.gz
	(cd $(PROYECTO)-$(PRY_VERSION); ./conf.sh; make $(PROYECTO)-$(PRY_VERSION)_html.tar.gz)
	cp $(PROYECTO)-$(PRY_VERSION)/$(PROYECTO)-$(PRY_VERSION)_html.tar.gz .

ghtodo: distgh
	(cd $(PROYECTO)-$(PRY_VERSION); ./conf.sh; make $(PROYECTO)-$(PRY_VERSION)_html.tar.gz)
	cp $(PROYECTO)-$(PRY_VERSION)/$(PROYECTO)-$(PRY_VERSION)_html.tar.gz .

repasa:
	DEF=$(PROYECTO).def CLA=$(PROYECTO).cla SEC=$(PROYECTO).sec DESC="Información extraida de: $(PRY_DESC)" FECHA="$(FECHA_ACT)" BIBLIO="$(URLSITE)" TIPO_DERECHOS="Dominio público" TIEMPO_DERECHOS="$(MES_ACT)" DERECHOS="Información cedida al dominio público. Sin garantías." AUTORES="Vladimir Támara" IDSIGNIFICADO="adJ_usuario" awk -f herram_confsh/db2rep $(SOURCES)

# Para usar DocBook
include herram_confsh/comdocbook.mak

# Para crear distribución de fuentes y publicar en Internet
include herram_confsh/comdist.mak

# Elimina hasta configuración
limpiadist: limpiamas
	rm -f confv.sh confv.xml Make.inc personaliza.ent
	rm -rf $(HTML_DIR)
	rm -rf $(PRINT_DIR)


# Elimina archivos generables
limpiamas: limpia
	rm -f img/*.eps img/*.ps
	rm -f $(PROYECTO)-$(PRY_VERSION).tar.gz
	rm -f genindice.xdbk genindice.xdbk.m genindice.xml.m HTML.index.m
	rm -rf $(PROYECTO)-$(PRY_VERSION)
	rm -rf $(PROYECTO)_gh-pages
	rm -f $(INDEX).xdbk $(INDEX).xdbk.m $(INDEX).xml.m HTML.index.m
	rm -f confaux.sed indice.xdbk.m confv.ent


# Elimina backups y archivos temporales
limpia:
	rm -f *.bak *~ *.tmp confaux.tmp $(PROYECTO)-$(PRY_VERSION)_html.tar.gz
	rm -f $(PROYECTO)-4.1.*
	rm -f $(FUENTESDB)


Derechos.txt: $(PROYECTO).$(EXT_DOCBOOK)
	make html/index.html
	$(W3M) $(W3M_OPT) -dump html/index.html | awk -f herram_confsh/conthtmldoc.awk | awk '/Expresamos/ { e = 1; } /.*/ { if (e != 1) { print $0; }}' | fmt > Derechos.txt

instala:
	mkdir -p $(DESTDIR)$(INSDOC)/img/
	install html/*html $(DESTDIR)$(INSDOC)
	install html/img/*png $(DESTDIR)$(INSDOC)/img/
	if (test -f $(PRINT_DIR)/$(PROYECTO).ps) then { \
		install imp/*ps $(DESTDIR)$(INSDOC);\
	} fi;

repasa:
	DEF=$(PROYECTO).def CLA=$(PROYECTO).cla SEC=$(PROYECTO).sec DESC="Información extraida de: $(PRY_DESC)" FECHA="$(FECHA_ACT)" BIBLIO="$(URLSITE)" TIPO_DERECHOS="Dominio público" TIEMPO_DERECHOS="$(MES_ACT)" DERECHOS="Información cedida al dominio público. Sin garantías." AUTORES="Vladimir Támara" IDSIGNIFICADO="openbsd_usuario" awk -f herram_confsh/db2rep $(SOURCES)


paquetes-adJ.xdbk: infoversion.ent
	if (test -f /home/$(LOGNAME)/comp/adJ/Contenido.txt) then { cp /home/$(LOGNAME)/comp/adJ/Contenido.txt Contenido.txt; } else { touch Contenido.txt; } fi;
	awk -f herram/convContenido.awk Contenido.txt > paquetes-adJ.xdbk; 

#if (test -f /home/$(LOGNAME)/comp/adJ/Contenido.txt) then { cp /home/$(LOGNAME)/comp/adJ/Contenido.txt Contenido.txt ; recode utf8..latin1 Contenido.txt; } else { touch Contenido.txt; } fi;

infoversion.ent:
	if (test -f ../servidor_adJ/infoversion.ent) then { \
		cp ../servidor_adJ/infoversion.ent .; \
	} fi;

openbsdsrc/tabcompose.xdbk:
	(cd openbsdsrc; ./gensym.sh)
