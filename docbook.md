### DocBook

Puede configurarse tanto DocBook SGML 4.4 y procesarse con las hojas de
estilo DSSSL, o bien DocBook XML 4.4 y procesarse con `xsltproc`.

#### SGML 4.4 con DSSSL {#sgml-4-4-con-dsssl}

Instale los paquetes openjade, docbook y docbook-dsssl:

        doas pkg_add $PKG_PATH/P-DOCBOOK.tgz
        doas pkg_add $PKG_PATH/P-DOCBOOK-DSSSL.tgz
        doas pkg_add $PKG_PATH/P-OPENJADE.tgz 

Esto bastará para hacer conversiones de DocBook SGML a HTML por ejemplo
si su hoja de estílo DSSL es "marcos.dsl" y va a convertir el documento
DocBook marcos.xml:

        openjade  -t sgml -ihtml -d marcos.dsl#html marcos.xml 

Para convertir a PostScript además de los paquetes anteriores requiere
el paquete texlive (ver [TeX y Ghostview](#conf-tex-gv)) y el paquete
jadetex

#### XML 4.4 con XSL {#xml-4-4-con-xsl}

Cómo parte del paquete `` se instalará el DTD de DocBook XML 4.4 en el
directorio `/usr/local/share/xml/docbook`. Es recomendable que cree el
archivo `/usr/local/share/xml/catalog` inicialmente con:

        CATALOG "docbook/catalog" 

y que agregue en este archivo la ruta de otros catálogos XML o de DTDs.

Para transformar documentos XML con hojas de estilo XSL puede emplear un
procesador como `xsltproc`, que está incluido en el paquete `libxslt`.
Esta herramienta recibe el nombre del archivo XSL y el nombre del
archivo XML por transformar. También puede recibir la opción
`--catalogs` que indica usar los catálogos de la variable
`SGML_CATALOG_FILES` (se separan unos catálogos de otros con el carácter
':'), o la opción `--nonet` que indica no descargar DTDs de Internet
(los catálogos deben resolver todos los identificadores públicos).

Las hojas de estilo XSL para transformar DocBook XML en HTML y en XML-FO
(Formatting objects, apropiado para imprimir con un procesador FO) se
instalan con el paquete `` y quedan en `/usr/local/share/xsl/docbook`.

Una vez instalados todas las partes puede procesar el archivo
`ejemplo.xdbk`:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"  "/usr/local/share/xml/docbook/4.4/docbookx.dtd" > 

    <article lang="es">
        <title>articulo</title>
      <articleinfo>
        <authorgroup>
          <author>
        <firstname>Nombres</firstname>
        <surname>Apellidos</surname>
        <authorblurb>
              <para><address>
              <email>micorreo@pasosdeJesus.org</email>
               </address></para>
        </authorblurb>
          </author> 
        </authorgroup>
        
        <abstract>
            <para>Resumen</para>
        </abstract>

        <legalnotice>
            <para>nota legal</para>
        </legalnotice>

      </articleinfo>

      <sect1 id="s1">
        <title>Primera sección</title>

        <para>Parrafo</para>
      </sect1>
    </article>

con una hoja XSLT de DocBook con:

        export SGML_CATALOG_FILES="/usr/local/share/xml/catalog"
        xsltproc --catalogs --nonet /usr/local/share/xsl/docbook/html/chunk.xsl ejemplo.xdbk
