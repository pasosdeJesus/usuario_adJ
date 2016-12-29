Ayudas para la instalación {#ayudas-para-la-instalacion}
--------------------------

Es muy recomendable consultar [guía de instalación de
OpenBSD](http://www.openbsd.org/faq/faq4.html#4.1).

Si tiene el DVD oficial, configure su BIOS para que arranque por este y
reinicie[^1]. Este DVD contiene un sistema OpenBSD mínimo que detectará
automáticamente el hardware y lo guiará en el proceso de instalación. Si
había creado con anterioridad la partición primaria para OpenBSD
seguramente no tendrá inconveniente en esta instalación, basta que tenga
en cuenta algunas diferencias entre Linux y OpenBSD:

Nombres y manejo de dispositivos

:   
      Dispositivo                  Linux                                                             OpenBSD
      ---------------------------- ----------------------------------------------------------------- -------------------------------------------------------------------------------
      Disco IDE 1 maestro          `/dev/hda`                                                        `/dev/wd0c` o en modo crudo `/dev/rwd0c`
      Disco SCSI                   `/dev/sda`                                                        `/dev/sd0c` o en modo crudo `/dev/rsd0c`
      Mouse                        `/dev/psaux` o `/dev/ttyS0`, `/dev/ttyS1` ...                     `/dev/wsmouse` si es PS/2. Si es serial uno como `/dev/tty00` o `/dev/tty01`.
      Teclado                      `/dev/kbd`                                                        `/dev/wskbd`
      Primera unidad de disquete   `/dev/fd0`                                                        `/dev/fd0c`[^2]
      Primera unidad de DVD        Si es IDE algo como `/dev/hdb`, si es SCSI algo como `/dev/sda`   `/dev/cd0c`

      : Nombres de dispositivos

    En Linux los controladores están en módulos algunos de los cuales
    deben configurarse con herramientas externas al kernel o
    manualmente. En OpenBSD los controladores están integrados en el
    kernel y normalmente detectan los dispositivos y se configuran
    automáticamente. Si durante el arranque del disquete o del sistema
    algún dispositivo soportado no logra ser detectado o configurado
    puede emplear `boot -c` en el prompt de arranque para entrar a un
    editor de las variables de configuración del kernel y ajustar
    manualmente los recursos para el dispositivo.

Sistema básico y portes

:   Notará que la instalación es muy corta porque sólo se instala un
    sistema básico, que consta del kernel, comandos básicos (de `/bin` y
    `/sbin` y `/usr/lib`), archivos de configuración (de `/etc`) y
    eventualmente, si los escoge al instalar, compilador, documentación
    y el servidor X-Window. Estos componentes conforman OpenBSD y han
    sido ampliamente auditados.

    Después de instalar el sistema básico podrá instalar programas que
    han sido portados pero que no han pasado por un proceso de revisión
    tan intenso como el de los componentes básicos (ver [Paquetes y
    portes](#paquetes-y-portes)).

Particiones

:   OpenBSD puede dividir la partición que haya destinado para este
    sistema en "subparticiones". Tenga en cuenta no transpasar los
    límites de la partición que reservó para OpenBSD al definir esta
    subparticiones con el programa `disklabel` (el mismo programa le
    ayudará a evitarlo). Los componentes básicos del sistema estarán
    especialmente en `/usr`, mientras que los paquetes emplearán
    `/usr/local`

    Para un sistema de escritorio puede bastar dividir el espacio de su
    partición para OpenBSD en: `/` (al menos con 3G o si desea instalar
    los paquetes incluidos en el DVD y para compilar fuentes al menos
    con 50G), `/home` (con tanto espacio como desee para los usuarios) y
    `/var` (al menos con 1.2G si planea sacar respaldos de imagenes
    encriptadas en CD o de 8G si planea sacarlas en DVD).

Interprete de comandos

:   Por defecto emplea `ksh` que es muy parecido a `bash`. Hay también
    un paquete de `bash` que podría instalar después de tener en
    operación el sistema básico.

Herramientas UNIX

:   Notará también que otros programas (como `sed`, `awk`, `tar` y
    `make`) tienden a conformar el estándar POSIX pero no algunas
    extensiones comunes en sistemas Linux.

[^1]: El método de instalación por red PXE requiere que configure otro
    servidor con los servicios DHCP para asignarle dirección durante la
    instalación y TFTP para que pueda servirle el archivo de arranque
    `boot` y un kernel como `bsd`

[^2]: En discos, DVDs y disquettes las particiones se indican con a, b,
    d y letras que se usan como postfijo. El postfijo c representa el
    disco/DVD/disquette completo. Por ejemplo en el caso del primer
    disco IDE las particiones pueden ser: `/dev/wd0a`, `/dev/wd0b`,
    `/dev/wd0d` y así sucesivamente, mientras que `/dev/wd0c` representa
    el disco completo. Pueden verse las particiones precisas que se usan
    del primer disco IDE con `disklabel /dev/wd0c`
