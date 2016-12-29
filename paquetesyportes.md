# Paquetes y portes {#paquetesyportes}

Diversos programas han sido portados a OpenBSD; a las fuentes
portadas se les llama portes y a los binarios de alguno de los
portes compilados para alguna plataforma se les llama paquetes.

## Paquetes

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

## Portes

Aunque NetBSD y FreeBSD tienen más programas portados que OpenBSD, la
colección de portes de OpenBSD ya cuenta con casi 5000 programas
clasificados en las siguientes categorías empleadas por el sistema de
portes: archivers, astro, audio, benchmarks, biology, books, cad,
chinese, comms, converters, databases, devel, distfiles, editors,
education, emulators, games, graphics, infrastructure, japanese, java,
korean, lang, mail, math, mbone, misc, multimedia, net, news, palm,
plan9, print, productivity, russian, security, shells, sysutils,
telephony textproc, www, x11.

Puede ver el desarrollo de los portes en:
[http://openports.se](http://openports.se/) y más información sobre
portes y paquetes en: <http://www.openbsd.org/ports.html>

Si prefiere compilar los paquetes que va a instalar o desea ayudar a
portar aplicaciones a OpenBSD debe tener las fuentes de los portes
(parches, makefiles y scripts), que normalmente se ubican en
`/usr/ports`. Puede bien descomprimirlas de un CD oficial, o de un
servidor FTP y después actualizarlas de un repositorio CVS o bien
descargarlas de un repositorio CVS como se presenta a continuación:

        cd /usr
        export CVSROOT=anoncvs@anoncvs.de.openbsd.org:/cvs
        cvs -z3 -q get -rOPENBSD_VER-OPENBSD-U -P ports 

La vía para `CVSROOT` adaptela a su servidor más cercano, escogiendo
entre los disponibles en: <http://www.openbsd.org/anoncvs.html>.

### Busquedas de portes {#busquedas-portes}

Para buscar un programa en la colección de portes puede emplear:

        cd /usr/ports
        make search key=cadena
          

Que presentará los portes que en su descripción tengan la cadena dada.
Esta busqueda se realiza sobre el archivo `/usr/ports/INDEX`, el cual si
lo desea también puede explorar con un editor.

### Compilación de portes {#compilación-portes}

Para compilar e instalar un porte (tras la compilación normalmente se
crea un paquete), basta pasar al directorio del porte y como usuario
root ejecutar:

        make install 

El respectivo `Makefile` obtendrá las fuentes originales de la red,
aplicará los cambios necesarios, compilará, creará un paquete y lo
instalará (posteriormente podrá eliminar el paquete con `pkg_delete` ver
[Paquetes](#paquetes)). Si el porte tiene otros portes como
prerequisitos los compilará e instalará antes.

### Creación de un porte

Elija una categoría para su porte (i.e un directorio en `/usr/ports`),
puede copiar el directorio de un porte similar al que desea hacer y
modificarlo. Emplee como nombre de directorio el nombre del paquete (sin
versión). Debe tener al menos estos archivos:

Makefile

:   El cual incluye descripción corta, nombre del paquete, versión, URL
    del cual descargar fuentes, el correo de quien mantiene el porte,
    URL de parches si los hay, información sobre posibilidad de
    redistribución, foma de configurar, compilar e instalar. Este
    archivo normalmente es muy corto pues se basa en la infraestructura
    para portes de `/usr/ports/infrastructure/mk/bsd.ports.mk`.

distinfo

:   Este archivo incluye diversas "firmas"[^1] de cada fuente que debe
    descargarse para asegurar su integridad. Se genera automáticamente
    con `make makesum` y se verifica con `make checksum`

pkg/DESCR

:   Este archivo incluye una descripción un poco más larga del paquete
    (la que presenta `pkg_info` cuando se corre sin opciones).

pkg/PLIST

:   Indica los archivos que se instalan después de instalar el paquete.
    Se puede crear un candidato inicial de este archivo después de
    compilar y hacer una instalación de prueba (`make
                  fake`). Puede actualizarse de acuerdo a lo instalado
    con `make plist`

patches/

:   En este directorio se mantienen parches que deben aplicarse a las
    fuentes descargadas. Puede generarlos automáticamente (con
    `make patches`), si en el directorio donde se descomprimen las
    fuentes, saca una copia de cada archivo que vaya a modificar y le
    agrega el sufijo `.orig`

Crear un porte es un proceso iterativo, en cada iteración debe refinarse
el porte para asegurar que cumple con todos los lineamientos que espera
el equipo de portes de OpenBSD. Puede consultar más en porting-checklist
porting.

[^1]: Resultados de pasar archivos por funciones de hashing.
