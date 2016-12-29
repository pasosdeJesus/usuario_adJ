Kernel
------

Algunas configuraciones pueden hacerse con `sysctl`, otras MUY inusuales
requieren recompilación del kernel.

### Compilación del kernel {#compilacion-del-kernel}

Puede sacar las fuentes del CD de instalación o de un repositorio FTP
(`src.tgz`) descomprimiendolas en `/usr/src`, después puede
actualizarlas con el CVS de OpenBSD con:

        cd /usr
        export CVSROOT=anoncvs@anoncvs.de.openbsd.org:/cvs
        cvs -z3 co -rOPENBSD_VER-OPENBSD-U -P src 

empleando un espejo más cercano a su computador y cambiado
OPENBSD\_VER-OPENBSD-U por la versión que desea actualizar, o si las
fuentes que tiene son la versión que desea puede emplear:

        cd /usr/src
        export CVSROOT=anoncvs@anoncvs.de.openbsd.org:/cvs
        cvs -z3 update -r OPENBSD_VER-OPENBSD-U -Pd 

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
          
