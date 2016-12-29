Operaciones con DVD {#dvd}
-------------------

El sistema de archivos de los DVD es UDF, que es diferente al de los CDs
(ISO9660). Desde la versión 4.0, OpenBSD soporta las versiones 1.02 y
1.50 de UDF en modos plain y VAT (ver []()

Las operaciones de montaje de DVDs, montaje de imagenes y copia de DVDs
a disco son como las de CDs remplazando el tipo `cd9660` por `udf` (ver
[???](#montar-cd), [???](#montar-imagen-iso) y
[???](#crear-imagen-de-cd)).

Para quemar DVDs es necesario instalar el paquete `cdrtools`, el cual
incluye el programa `growisofs` que permite quemar DVDs al menos de dos
formas:

1.  Incluir una serie de archivos sin necesidad de preparar previamente
    una imagen del DVD. Por ejemplo para quemar un DVD que tenga los
    archivos `/home/copia/a` y `/home/copia/b`:

            doas growisofs -Z /dev/rcd0c -R /home/copia/a /home/copia/b
              

2.  Para quemar un DVD con la imagen ISO `dvd.iso`

            doas growisofs -dvd-compat -Z /dev/rcd0c=dvd.iso
                          

### Referencias {#referencias-dvd}

`man mount_udf` y `man growisofs`.

Universal Disk Format:
[](http://en.wikipedia.org/wiki/Universal_Disk_Format)
