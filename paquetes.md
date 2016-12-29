Paquetes
--------

Cada paquete es un archivo con extensión `.tgz` que incluye información
de dependencias y scripts para instalar y desinstalar. Para manejarlos
se emplean los programas `pkg_add`, `pkg_delete`, `pkg_info` y
`pkg_create`. El programa `pkg_add` instala un paquete y todos los que
este requiera, usando para descargarlos lo(s) repositorio(s)
especificada(s) en la variable de ambiente `PKG_PATH`, por esto en el
archivo `~/.profile` o en `~/.xsession` vale la pena agregar:

        export PKG_PATH=ftp://ftp.pasosdeJesus.org/pub/OpenBSD/VER-OPENBSD/packages/amd64

o la vía del CD-ROM 1 o una vía de un espejo más rápido para su
caso[^1]. Una vez establecida esta variable, para agregar por ejemplo el
paquete `P-VIM.tgz`:

        pkg_add $PKG_PATH/P-VIM.tgz 

Puede ver la lista de paquetes instalados en su sistema con `pkg_info` o
con `ls -l /var/db/pkg`, podrá desinstalar uno con `pkg_delete` seguido
del nombre del paquete (con la opción `-f dependencies` se eliminarán
también paquetes que dependan del que está quitando --que es útil si
está actualizando un paquete).

Podrá ver los paquetes disponibles para instalar en
[http://www.openbsd.org/VER-OPENBSD\_packages/amd64.html](http://www.openbsd.org/&VER-OPENBSD;_packages/amd64.html).
A continuación destacamos algunos que permiten tener un ambiente para
producir contenidos, programar, escuchar música y ver vídeos (se
incluyen en la distribución [adJ](http://aprendiendo.pasosdeJesus.org)):
PROGRAMAS

### Actualización de paquetes {#actualizacion-paquetes}

Podrá actualizar un paquete con `pkg_add -r -D update paquete.tgz`

Si configura `PKG_PATH` podrá buscar dependencias que debe actualizar
para actualizar un paquete con `pkg_add -u paquete`.

Cada paquete instalado crea un directorio con el nombre del paquete en
`/var/db/pkg` por lo que además de `pkg_info -L` puede usar

        ls /var/db/pkg
            

Y para actualizar todos los paquetes puede utilizar

        doas pkg_add -u 
            

[^1]: Para determinarlo puede ver la velocidad de cada espejo con algo
    como `ping ftp.pasosdeJesus.org` o emplear el script `pos.sh` que
    hará la prueba para los espejos oficiales de OpenBSD. Está en el
    directorio `herram` de las fuentes de este escrito.
