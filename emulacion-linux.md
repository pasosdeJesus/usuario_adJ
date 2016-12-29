Emulación de binarios para Linux {#emulacion-linux}
--------------------------------

Algunas aplicaciones cuyas fuentes no han sido portadas a OpenBSD pueden
ejecutarse con las capas de emulación de OpenBSD. En particular para
i386 hay capas de emulación para binarios de Linux, FreeBSD, BSDI y SCO
Unix (binarios iBCS2). Aquí se describe brevemente la emulación de
binarios para Linux (ver `man
    compat_linux`).

Para comenzar rapidamente puede utilizar el paquete `redhat_base` que
instalará librerías compartidas y archivos básicos de una distribución
Redhat con `libc`. Cree un enlace para que la emulación logre ubicar
información donde la espera:

        mkdir -p emul
        ln -s /usr/local/emul/redhat /emul/linux
          

Active la emulación de Linux en el kernel usando
`sysctl -w kern.emul.linux=1` y haga que el cambio se repita cada vez
que reinicie, moficando `/etc/sysctl.conf`[^1] para que incluya la
línea:

        kern.emul.linux=1
          

Después de hacer esto o de copiar nuevas librerías que algún programa
requiera, debe ejecutar `/emul/linux/sbin/ldconfig`. Para automatizar
esta tarea durante cada arranque puede agregar a su archivo
`/etc/rc.local`:

        if (test -x /emul/linux/sbin/ldconfig) then {
              /emul/linux/sbin/ldconfig
        } fi; 

Con el enlace que hizo, en el directorio `/emul/linux` quedará una
jerarquía de directorios como la raíz de un sistema Linux (excepto por
que no tiene kernel).

Al ejecutar un binario para Linux, OpenBSD transformará los nombres que
el programa requiera suponiendo que `/emul/linux` es la raíz. Si un
archivo que se debe leer no es encontrado allí, OpenBSD intenta como
segunda opción en la raíz real del sistema. Por ejemplo si después de
instalar `redhat_base` y crear el enlace intenta:

        /emul/linux/bin/cp /bin/bash / 

es decir ejecuta `cp` de Linux, el archivo `/emul/linux/bin/bash` (que
es dejado allí por `redhat_base`) será copiado a `/emul/linux`. Pero si
ejecuta

        /emul/linux/bin/cp /bin/ksh / 

como el archivo `/emul/linux/bin/ksh` no existe (`redhat_base` no lo
incluye), se copiará el archivo `/bin/ksh` (`ksh` de OpenBSD) en la raíz
de Linux (i.e `/emul/linux`).

Si desea ver su sistema como si la raíz fuera `/emul/linux` (digamos
para ejecutar varios programas Linux) puede emplear:

        /emul/linux/bin/bash 

que iniciará un interprete de comandos compilado para Linux (así que las
vías de ese interprete de comandos son las que ven todos los binarios de
Linux).

Aunque la emulación no es perfecta funcionan varios programas (como el
compilador `gcc`), de hecho algunos paquetes OpenBSD emplean esta capa
(e.g `jdk-1.3-linux`).

Para emplear una distribución de Linux diferente basta asegurar que
pueda accederse desde `/emul/linux`. Por ejemplo si en la partición
`/dev/wd0i` tiene un sistema Debian, puede agregar la siguiente línea a
`/etc/fstab` para montarla automáticamente durante el arranque:

        /dev/wd0i /mnt/debian ext2fs rw 1 1 

Cree un enlace de `/emul/linux` a `/mnt/debian` (creando antes el
directorio `/mnt/debian`) y recuerde ejecutar `ldconfig` para que las
librerías compartidas pueda ser ubicadas.

[^1]: El kernel genérico permite hacer el cambio de esta manera porque
    fue compilado con la opción de configuración `COMPAT_LINUX`
