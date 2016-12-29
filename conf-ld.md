ld
--

`ld` es el programa que carga otros programas junto con las librerías
compartidas que requieran y resuelve los símbolos. Para buscar librerías
compartidas emplea la información de `/var/run/ld.so.hints` (que puede
examinarse con `ldconfig -r`).

Con `ldd` pueden examinarse las librerías compartidas que un programa
requiere, por ejemplo:

        ldd /usr/bin/less
        

Cuando se agregan librerías compartidas o se requiere que las librerias
de nuevos directorios sean referenciados en `/var/run/ld.so.hints` puede
ejecutar `ldconfig` (que por defecto busca nuevas librerías en
`/usr/lib`). Por ejemplo durante el arranque en un sistema con X-Window
se ejecuta:

        ldconfig /usr/local/lib /usr/X11R6/lib
        

También pueden especificarse otros directorios por usar durante el
arranque definiendo la variable `shlib_dirs` en `/etc/rc.conf.local`
(ver [???](#inicio-del-sistema))

Incluso un usuario puede establecer otros directorios donde buscar
librerías compartidas especificandolos en la variable de entorno
`LD_LIBRARY_PATH` (separar un directorio de otro con ':' ).
