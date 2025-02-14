# Paquetes y portes {#paquetesyportes}

Diversos programas han sido portados a OpenBSD; a las fuentes
portadas se les llama portes y a los binarios de alguno de los
portes compilados para alguna plataforma se les llama paquetes.

## Paquetes

Cada paquete es un archivo con extensión `.tgz` que incluye información
de dependencias, scripts para instalar y desinstalar así como una
firma criptográfica para garantizar que procede de una fuente confiable. 
Para manejarlos se emplean los programas `pkg_add`, `pkg_delete`, `pkg_info` y
`pkg_create`. 

El programa `pkg_add` instala un paquete y todos los que
este requiera.  Intenta localizar el paquete y sus dependencias en este 
orden:
  1. En el directorio de trabajo
  2. Si no se encontró en el directorio de trabajo, usará el repositorio 
     especificado en la variable de ambiente `TRUSTED_PKG_PATH` (de donde
    instalará paquetes incluso no firmados).  Esa variable puede referirse a 
    un directorio local o remoto (con ftp, http, https o scp)
  3. Si no se especifica `TRUSTED_PKG_PATH` o no se encuentra allí,
     buscar en el repositorio especificado en la variable `PKG_PATH`
  4. Si no se especificaron `TRUSTED_PKG_PATH` ni `PKG_PATH` usara
     el repositorio especificado en `/etc/installurl` que de manera
     predeterminada es `https://cdn.openbsd.org/pub/OpenBSD`

Por esto en el archivo `~/.zshrc` o en `~/.profile` o en `~/.xsession` 
vale la pena agregar:

        export PKG_PATH=http://adJ.pasosdeJesus.org/pub/OpenBSD/&VER-OPENBSD;/packages/amd64

o una vía de un espejo más rápido para su caso[^paq.1]. 
Una vez establecida esta variable, para agregar por ejemplo el
paquete `&p-vim;.tgz`:

        pkg_add $PKG_PATH/&p-vim;.tgz 

[^paq.1]: Para determinarlo puede ver la velocidad de cada espejo con algo
    como `ping ftp.pasosdeJesus.org` o emplear el script 
    `/usr/local/share/doc/usuario_adJ/pos.sh` que
    hará la prueba para los espejos oficiales de OpenBSD. Es script
    es instalado con el paquete `usuario_adJ` que corresponde a esta
    documentación.

Puede ver la lista de paquetes instalados en su sistema con `pkg_info` o
con `ls -l /var/db/pkg`, podrá desinstalar uno con `pkg_delete` seguido
del nombre del paquete (con la opción `-f dependencies` se eliminarán
también paquetes que dependan del que está quitando --que es útil si
está actualizando un paquete).

Podrá ver los paquetes disponibles para instalar en
[http://www.openbsd.org/&VER-OPENBSD;\_packages/amd64.html](http://www.openbsd.org/&&VER-OPENBSD;;_packages/amd64.html).

En el [Apéndice Paquetes de adJ](#paquetes-adJ) destacamos algunos que 
permiten tener un ambiente para producir contenidos, programar, escuchar 
música y ver vídeos (se incluyen en la distribución 
[adJ](http://aprendiendo.pasosdeJesus.org)).


### Actualización de paquetes {#actualizacion-paquetes}

Podrá actualizar un paquete con `pkg_add -r -D update paquete.tgz`

Si configura `PKG_PATH` podrá buscar dependencias que debe actualizar
para actualizar un paquete con `pkg_add -u paquete`.

Cada paquete instalado crea un directorio con el nombre del paquete en
`/var/db/pkg` por lo que además de `pkg_info -L` puede usar

        ls /var/db/pkg


Y para actualizar todos los paquetes puede utilizar

        doas pkg_add -u 


## Portes

Aunque NetBSD y FreeBSD tienen más programas portados que OpenBSD, la
colección de portes de OpenBSD ya cuenta con casi 10000 programas
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
        cvs -z3 -q get -rOPENBSD_&VER-OPENBSD-U; -P ports 

La vía para `CVSROOT` adáptela a su servidor más cercano, escogiendo
entre los disponibles en: <http://www.openbsd.org/anoncvs.html>.

### Búsquedas de portes {#busquedas-portes}

Para buscar un programa en la colección de portes puede emplear:

        cd /usr/ports
        make search key=cadena
          
Que presentará los portes que en su descripción tengan la cadena dada.
Esta búsqueda se realiza sobre el archivo `/usr/ports/INDEX`, el cual si
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
    redistribución, forma de configurar, compilar e instalar. Este
    archivo normalmente es muy corto pues se basa en la infraestructura
    para portes de `/usr/ports/infrastructure/mk/bsd.ports.mk`.

distinfo

:   Este archivo incluye diversos "condensados"[^cre.1] de cada fuente que debe
    descargarse para asegurar su integridad. Se genera automáticamente
    con `make makesum` y se verifica con `make checksum`

pkg/DESCR

:   Este archivo incluye una descripción un poco más larga del paquete
    (la que presenta `pkg_info` cuando se corre sin opciones).

pkg/PLIST

:   Indica los archivos que se instalan después de instalar el paquete.
    Se puede crear un candidato inicial de este archivo después de
    compilar y hacer una instalación de prueba (`make fake`). 
    Puede actualizarse de acuerdo a lo instalado con `make plist`

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

[^cre.1]: Resultados de pasar archivos por funciones de hashing.
