
# Configuración y uso de programas y servicios básicos {#configuracion-de-componentes-basicos}

## pdksh (ksh) {#pdksh}

Es un intérprete de ordenes similar a `bash`. Este intérprete de
ordenes al iniciarse como intérprete de login lee los archivos
`/etc/profile` y `$HOME/.profile`, pero no lo hace si es iniciado como
intérprete interactivo. Puede iniciarse explícitamente como intérprete
de login con `ksh -l`. Esto puede resultar útil para iniciarlo por
ejemplo dentro de `xterm`:

        xterm -en utf8 -e /bin/ksh -l 

El método de edición (`vi`,`emacs` o `gmacs`) se configura en la
variable `VISUAL`.


## ftp {#ftp}

Además de las características usuales de un cliente `ftp` (RFC 959,
extendido en RFC 1123), el cliente `ftp` de OpenBSD:

-   Realiza conexiones pasivas por defecto. Sin embargo algunos
    servidores de ftp requiere conexiones activas, si ese es el caso
    (por ejemplo cuando el servidor responde a `ls` con
    `425 Can't open data connection`) emplee la opción `-A`.

-   Emplea el archivo de configuración `~/.netrc` para establecer
    conexiones automáticamente. En ese archivo usted puede especificar
    servidores a los que suele conectarse (y por ejemplo emplear
    redireccionamiento para automatizar operaciones . Este archivo puede
    tener comentarios (líneas iniciadas con el caracter '\#') o líneas
    como:

            machine &ESERV; login &EUSUARIO;
            machine rt.fm login anonymous passwd &EUSUARIO;@&EDOMINIO;
                

    que indican emplear el usuario &EUSUARIO; al conectarse a &ESERV;
    (pedirá la clave al hacer la conexión) y emplear el usuario
    `anonymous`, con clave `&EUSUARIO;@&EDOMINIO;` al hacer conexiones con
    `rt.fm`.

    > ![Aviso](img/warning.png) **Advertencia**
    >
    > Las claves que se almacenan en este archivo son textos planos que
    > el superusuario del sistema podría ver. Para que otros usuarios no
    > puedan verlas quite el permiso de lectura para otros usuarios y
    > para el grupo:
    >
    >         chmod og-r ~/.netrc

-   Permite especificar el URL (iniciado con `http://` o `ftp://`) de un
    archivo por descargar en la línea de ordenes (y realiza
    autenticación automática si es ftp:// y se ha configurado
    `~/.netrc`, o si el URL es análogo a
    `ftp://&EUSUARIO;:miclave@&ESERV;/pub/doc.txt`). En este caso si se
    requiere puede emplearse la opción `-o` seguida del nombre del
    archivo con el que se desea salvar el archivo transmitido. También
    puede emplearse `*` para indicar transmisión de varios archivos.


## doas

Este programa permite ejecutar ordenes privilegiadas a algunos
usuarios. A partir de adJ y OpenBSD 5.8 el sistema base incluye `doas`
como remplazo del antiguo `sudo`. `doas` es más simple y fácil de
auditar.

Se configura en `/etc/doas.conf`. Un ejemplo mínimo es:

        permit nopass keepenv :wheel

que permitirá su uso sin requerir clave a todos los usuarios del grupo
`wheel` manteniendo las varibles de ambiente.

Una vez configurado, puede ejecutar una orden privilegiada desde una
cuenta configurada con `doas orden`. Por ejemplo:

        doas vi /etc/rc.conf.local 

### sudo

El programa `sudo` se mantiene como paquete, si lo requiere instalelo
desde la cuenta `root` con:

        pkg_add sudo

Se configura en `/etc/sudoers` que debe editarse con `visudo`.

Consulte los ejemplos allí presentados en líneas con comentarios y quite
el comentario a la configuración que considere apropiada. Por ejemplo si
desea que todo usuario que esté en el grupo `wheel` pueda emplear `sudo`
sin necesidad de ingresar una clave, quite el comentario a la línea:

        %wheel  ALL=(ALL)       NOPASSWD: ALL

Puede verse en <http://rr.sans.org/authentic/sudo.php> interacción entre
`sudo` y `ssh` para administrar una red.

##`cron`: para programar tareas {#cron}

El programa `cron` ejecuta tareas configuradas para correr en cierto(s)
momento(s). Este servico debe correr permanentemente. Puede comprar que
opera con `pgrep cron` que debe responder con el número del proceso. Si
no está corriendo debe ejecutarlo urgentemente bien reiniciando el
servido o ejecutando `doas cron`.

Cada minuto el programa `cron` busca tareas cuya ejecución esté
pendiente.

## ld {#ld}

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
(ver [xref](#inicio-del-sistema))

Incluso un usuario puede establecer otros directorios donde buscar
librerías compartidas especificandolos en la variable de entorno
`LD_LIBRARY_PATH` (separar un directorio de otro con ':' ).


## Kernel

Algunas configuraciones pueden hacerse con `sysctl`, otras MUY inusuales
requieren recompilación del kernel.

### Compilación del kernel {#compilacion-del-kernel}

Puede sacar las fuentes del CD de instalación o de un repositorio FTP
(`src.tgz`) descomprimiendolas en `/usr/src`, después puede
actualizarlas con el CVS de OpenBSD con:

        cd /usr
        export CVSROOT=anoncvs@anoncvs.de.openbsd.org:/cvs
        cvs -z3 co -r&VER-OPENBSD;_&VER-OPENBSD-U; -P src 

empleando un espejo más cercano a su computador y cambiado
&VER-OPENBSD;\_&VER-OPENBSD-U; por la versión que desea actualizar, o si las
fuentes que tiene son la versión que desea puede emplear:

        cd /usr/src
        export CVSROOT=anoncvs@anoncvs.de.openbsd.org:/cvs
        cvs -z3 update -r&VER-OPENBSD;_&VER-OPENBSD-U; -Pd 

Tal como se describe en `man afterboot`, para compilar basta editar el
archivo de configuración del kernel que se desea, después ejecutar
`config`, cambiar al directorio donde se compila y compilar. Por
ejemplo:

        cd /usr/src/sys/arch/amd64/conf
        vi GENERIC
        config GENERIC
        cd ../compile/GENERIC
        make clean
        make depend
        make
          

con esto se generará el ejecutable `bsd` en el directorio de
compilación, tal ejecutable puede usarse para reemplazar `/bsd`,
eventualmente dejando el kernel anterior listo para un arranque de
emergencia:

        mv /bsd /bsd.old
        mv bsd /bsd
          


## syslog

`syslogd` es un servidor que recibe mensajes de depuración y trazas de
diversos programas. Su archivo de configuración es `/etc/syslog.conf`,
cada línea de este archivo especifica que hacer con los mensajes
recibidos por uno o más programas.

Tras modificar `/etc/syslog.conf` puede obligarse a `syslogd` a leerlo
de nuevo enviado la señal HUP, por ejemplo:

    # ps ax | grep syslogd
    7723 ??  Is      0:00.06 syslogd 
    # kill -HUP 7723
        

### Referencias y lecturas recomendadas {#referencias-syslog}

Las siguientes páginas man: syslog.conf 8, syslog 3, syslogd 8 y logger
1.

## Zona horaria {#zona-horaria}

La zona horaria se establece enlazando ```/etc/localtime``` 
con una de las zonas del directorio ```/usr/share/zoneinfo```, 
por ejemplo

    doas ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime
