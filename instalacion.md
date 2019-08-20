# Sobre la instalación {#sobre-la-instalacion}

## Prerequisitos para la instalación {#prerequisitos-para-la-instalacion}

1.  Un computador con procesador de 64 bits de la familia x86 (hay
    imágenes de versiones anteriores a la 4.9 para procesadores de 32
    bits).

2.  Componentes básicos para la instalación en un medio que pueda
    acceder. Es decir en uno de los siguientes:

    -   DVD: Puede descargarlo de
        [estas fuentes]ftp://ftp.pasosdeJesus.org/pub/AprendiendoDeJesus) por
        ejemplo con el programa `ftp` de OpenBSD:

                ftp -C ftp://ftp.pasosdeJesus.org/pub/AprendiendoDeJesus/AprendiendoDeJesus&VER-ADJ;-amd64.iso


        o bien con el programa `wget`:

                wget -c ftp://ftp.pasosdeJesus.org/pub/AprendiendoDeJesus/AprendiendoDeJesus&VER-ADJ;-amd64.iso 


        Usando estas formas podrá reanudar la transferencia en caso de
        que se interrumpa. Otra posibilidad que tiene que puede acelerar
        la descarga, pero sin posibilidad de reanudar en caso de que se
        interrumpa, es emplear el programa `rsync`:

                rsync -vz rsync://ftp.pasosdeJesus.org/AprendiendoDeJesus/AprendiendoDeJesus&VER-ADJ;-amd64.iso.


        Note que hay un punto al final, que indica que el destino de la
        copia es el directorio actual. Si desea ver que otros archivos
        hay en el mismo directorio de esa imagen ISO utilice:

                rsync -vz rsync://ftp.pasosdeJesus.org/AprendiendoDeJesus/


    -   O bien partición ext2 (de Linux), ffs (de OpenBSD) o FAT (de DOS
        y Windows) con juegos de instalación.

    -   O bien conexión a Internet o una Intranet con una tarjeta de red
        (el disco de instalación NO soporta PPP ni SLIP) y un espejo del
        servidor FTP o HTTP que se pueda acceder rapidamente desde su
        computador.

    Aunque es posible realizar la descarga de imágenes ISO, recomendamos
    comprar[^pre.1] los CDs oficiales de instalación para apoyar los
    proyectos OpenBSD y adJ. La estructura del CD oficial de OpenBSD
    tiene derechos de reproducción restrictivos ---sólo la estructura,
    las fuentes son de libre redistribución en su mayoría cubiertas por
    la licencia BSD. Por esto en caso de comprar CDs oficiales cómprelos
    sólo a los desarrolladores o a redistribuidores autorizados. En el
    caso de OpenBSD ver <http://www.openbsd.org> y en el
    caso de adJ ver <https://aprendiendo.pasosdeJesus.org>.

3.  Contar con hardware soportado. La mayoría de componentes típicos son
    soportados, aunque hay excepciones por lo que antes de comprar se
    recomienda consultar la lista completa de los dispositivos para
    procesadores amd64 que son soportados en:
    <http://www.openbsd.org/amd64.html>.

4.  Una partición primaria de al menos 13GB en un disco duro, que
    comience en un cilindro arbitrario, pero en la cabeza 1 ---en lugar
    de la cabeza 0. Si planea comprar un computador con otro sistema
    operativo puede solicitarle al vendedor que le deje disponible una
    partición con estas características. Durante la instalación podrá
    asignar a esta partición el tipo OpenBSD (A6), podrá dividirla en
    etiquetas que son como subparticiones lógicas sólo visibles en
    OpenBSD (e.g para `/`, `/home` y `/var`) sobre cada una de las
    cuales podrá emplear el sistema de archivos de OpenBSD (Fast File
    System o `ufs` en terminología Linux). También podrá montar
    particiones de otros sistemas operativos, por ejemplo `ext2` está
    bien soportado, o tener un sistema dual (ver [xref](#duales)).

    Si en su computador no tiene una partición disponible, puede
    intentar cambiar el tamaño de una existente para liberar espacio y
    crear una nueva (sacando copia de respaldo antes de estas
    operaciones). Si una de las particiones tiene sistema FAT o FAT32
    (e.g con Windows 9x o XP) puede usar `fips`. Si la partición que
    desea redimensionar tiene formato ext2fs (Linux) puede usar `parted`
    o `resize2fs`. En el caso de particiones NTFS (Windows Vista o 7)
    puede usar `ntfsresize` desde un sistema Linux o arrancando con un
    disquette como [PAUD](http://paud.sourceforge.net/), o bien si
    prefiere utilidades gráficas para reparticionar puede arrancar desde
    un pequeño CD de rescate como
    [RIP](http://www.tux.org/pub/people/kent-robotti/looplinux/rip/) o
    por ejemplo con un CD instalador de Ubuntu.

5.  Leer la fe de erratas que incluye solucionas a eventuales problemas
    que tendrá durante la instalación o cuando concluya junto con
    soluciones:
    <http://aprendiendo.pasosdejesus.org/?id=AdJ+&VER-ADJ;+-+Aprendiendo+de+Jesus+&VER-ADJ;>

[^pre.1]: Los CDs de OpenBSD ordenados por la página web de OpenBSD si
    llegan a Colombia.

## Ayudas para la instalación {#ayudas-para-la-instalacion}

Es muy recomendable consultar [guía de instalación de
OpenBSD](http://www.openbsd.org/faq/faq4.html#4.1).

Si tiene el DVD oficial, configure su BIOS para que arranque por este y
reinicie[^ayu.1]. Este DVD contiene un sistema OpenBSD mínimo que detectará
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
      Primera unidad de disquete   `/dev/fd0`                                                        `/dev/fd0c`[^ayu.2]
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
    sistema básico, que consta del kernel, ordenes básicas (de `/bin` y
    `/sbin` y `/usr/lib`), archivos de configuración (de `/etc`) y
    eventualmente, si los escoge al instalar, compilador, documentación
    y el servidor X-Window. Estos componentes conforman OpenBSD y han
    sido ampliamente auditados.

    Después de instalar el sistema básico podrá instalar programas que
    han sido portados pero que no han pasado por un proceso de revisión
    tan intenso como el de los componentes básicos (ver [Paquetes y
    portes](#paquetesyportes)).

Particiones

:   OpenBSD puede dividir la partición que haya destinado para este
    sistema en "subparticiones". Tenga en cuenta no transpasar los
    límites de la partición que reservó para OpenBSD al definir estas
    subparticiones con el programa `disklabel` (el mismo programa le
    ayudará a evitarlo). Los componentes básicos del sistema estarán
    especialmente en `/usr`, mientras que los paquetes emplearán
    `/usr/local`

    Para un sistema de escritorio puede bastar dividir el espacio de su
    partición para OpenBSD en: `/` (al menos con 3G o si desea instalar
    los paquetes incluidos en el DVD y para compilar fuentes al menos
    con 50G), `/home` (con tanto espacio como desee para los usuarios) y
    `/var` (al menos con 1.2G si planea sacar respaldos de imágenes
    cifradas en CD o de 8G si planea sacarlas en DVD).

Interprete de ordenes

:   Por defecto emplea `ksh` que es muy parecido a `bash`. Hay también
    un paquete de `bash` que podría instalar después de tener en
    operación el sistema básico.

Herramientas UNIX

:   Notará también que otros programas (como `sed`, `awk`, `tar` y
    `make`) tienden a conformar el estándar POSIX pero no algunas
    extensiones comunes en sistemas Linux.

[^ayu.1]: El método de instalación por red PXE requiere que configure otro
    servidor con los servicios DHCP para asignarle dirección durante la
    instalación y TFTP para que pueda servirle el archivo de arranque
    `boot` y un kernel como `bsd`

[^ayu.2]: En discos, DVDs y disquettes las particiones se indican con a, b,
    d y letras que se usan como postfijo. El postfijo c representa el
    disco/DVD/disquette completo. Por ejemplo en el caso del primer
    disco IDE las particiones pueden ser: `/dev/wd0a`, `/dev/wd0b`,
    `/dev/wd0d` y así sucesivamente, mientras que `/dev/wd0c` representa
    el disco completo. Pueden verse las particiones precisas que se usan
    del primer disco IDE con `disklabel /dev/wd0c`

## Instalación y configuración del sistema base {#instalacion-y-configuracion-del-sistema-base}

Arranque por el medio de instalación, su prompt será algo como

		boot>
		
Si no arranca de inmediato el medio de instalación intente con

		boot> boot bsd.rd

Una vez pueda iniciar un medio con un instalador, el sistema reconocerá
las partes de su computador y esperará algunas respuestas de su parte,
como si desea instalar, actualizar o iniciar un intérprete de órdenes
para rescatar un sistema: 

![](img/instala1.png)

También podrá elegir distribución del teclado,
por ejemplo el teclado típico con 'ñ' y junto a esta un '{' corresponde
a 'es'. El instalador a continuación le permitirá configurar dispositivo
de red que usará, clave para la cuenta root y detalles para el inicio
del sistema entre los cuales es importante que confirme el uso de `xdm`,
la zona horaria (por defecto `America/Bogota`) y que cree una cuenta del
sistema (en este ejemplo servidor) que posteriormente podrá configurar
como cuenta de usuario administrador (`sshd` es un servicio que permite
operación remota con ssh, `ntpd` permite sincronizar reloj con
servidores para esto, X-Window es el entorno gráfico, `xdm` es el
programa que tras iniciar el entorno gráfico le permite autenticarse).


![](img/instala2.png)

En las capturas de pantalla de ejemplo hay un sólo disco duro que se
usará completo para OpenBSD, es decir tendrá una sóla partición del BIOS
que abarca todo el disco. De no usarse completo el instalador ingresará
al programa `fdisk` que le permitirá especificar la partición del BIOS
que destinará para OpenBSD (en `fdisk` la orden 'h' le presentará una
breve ayuda). 

![](img/instala3.png)

Tras definir el área del disco dedicada a OpenBSD podrá
definir etiquetas o subparticiones para el área de OpenBSD con el
programa `disklabel`. Aunque hay un modo de autolocalización de las
subparticiones se recomienda que cree su propio esquema de
subparticiones dejando al menos 10GB para la partición donde estará
`/usr/local` y al menos 1.2GB para `/var`. La orden 'h' en `disklabel`
presenta una breve ayuda. En el ejemplo siguiente se crean 4
subparticiones, la primera (`a`) siempre debe ser para el sistema raíz
(/), la segunda (`b`) siempre debe ser área de intercambio o swap (es
indispensable tenerla o podrá tener problemas de memoria posteriormente
con algunas aplicaciones), la partición `c` representa la partición del
BIOS completa y no debe tocarse, la tercera (`d`) corresponderá a
`/home` y la cuarta (`e`) a `/var`[^ins.1]. Note que con este esquema los
programas y sus datos estáticos (típicos de los directorios `/bin`,
`/sbin` y `/usr` quedarán en la subpartición `a`. Los datos de usuario
típicamente en `/home` quedarán en la subpartición `d`, y los datos
variables de los programas (e.g páginas web, bases de datos, bitácoras)
típicos de `/var` quedarán en la subpartición `e`. 

![](img/instala4.png)

Note que de cada
subpartición debe especificar desplazamiento (i.e sector en el que
comienza) y tamaño (i.e cantidad de sectores que ocupa). Tenga en cuenta
que un sector es de 512bytes, así que aproximadamente 2'000.000 de
sectores corresponden a 1GB. En el ejemplo anterior / es de
aproximadamente 10GB, la partición de intercambio es de 500MB, /home de
1GB y /var aproximadamente de 2.1GB. 

![](img/instala5.png)

Después de elegir subparticiones el instalador formateará las subparticiones. 
Después podrá especificar la ruta donde están los juegos de instalación 
(en el caso de la distribución Aprendiendo de Jesús es `/`) y elegir los que 
instalará. Podrá elegir entre:

bsd

:   Se trata del kernel genérico ya compilado para su plataforma

bsd.mp

:   El kernel con soporte para múltiples procesadores (SMP).

bsd.rd

:   El kernel pero que no usa dispositivos de almacenamiento sino un
    disco virtual en RAM (útil por ejemplo para hacer actualizaciones).

base&VER-OPENBSD-S;

:   Que es indispensable, porque además de la jerarquía de directorios
    incluye: los programas de los directorios `/bin`, `/usr/bin`,
    `/sbin`, `/usr/libexec` y `/usr/sbin`; las librerías de `/usr/lib`,
    `/usr/libdata` ; información de `/usr/share` y de `/var`. Entre los
    programas y servicios auditados que incluye están: herramientas
    estándar de Unix, servidor web Apache, OpenSSH, NIS, CVS, sendmail,
    NTP, IPv6, autenticación con Kerberos, NFS, NAT, AMD, AFS, perl y
    algunas herramientas de desarrollo.

etc&VER-OPENBSD-S;

:   También indispensable en sistemas que se instalan por primera vez
    (aunque no necesariamente si se hace actualización). Incluye los
    archivos de configuración del directorio `/etc` e información
    complementaria de `/var`.

comp&VER-OPENBSD-S;

:   Que incluye herramientas de desarrollo para Fortran, C y C++. Las
    librerías que estas requieren y la documentación de las llamadas al
    sistema y de las librerías.

man&VER-OPENBSD-S;

:   Que incluye documentación HTML, info y man de los programas y
    librerías de base&VER-OPENBSD-S;.

game&VER-OPENBSD-S;

:   Algunos juegos que se instalan en `/usr/games`

misc&VER-OPENBSD-S;

:   Que incluye información del directorio `/usr/share` como
    diccionarios y documentación complementaria.

xbase&VER-OPENBSD-S;

:   Programas básicos de X-Window (`/usr/X11R6/bin`), librerías
    (`/usr/X11R6/lib`) y su documentación (`/usr/X11R6/man`).

xfont&VER-OPENBSD-S;

:   Tipos de letra para X-Window (`/usr/X11R6/lib/X11/fonts`), para
    diversas codificaciones e idiomas, en resoluciones 100ppp y 75ppp.

xserv&VER-OPENBSD-S;

:   Servidores X-Window para diversas tarjetas de video, librerías para
    soportar fuentes y documentación.

xshare&VER-OPENBSD-S;

:   Encabezados y documentación complementaria de X-Window

site&VER-OPENBSD-S;

:   Requerido para continuar la instalación y configuración de
    Aprendiendo de Jesús. En particular archivo de ordenes
    `/usr/local/adJ/inst-adJ.sh` que deberá ejecutar como usuario
    administrador cuando haya reiniciado.

la instalación de los componentes indispensables (base&VER-OPENBSD-S; y
etc&VER-OPENBSD-S;) requiere cerca de 100MB, y la instalación de todos
requiere alrededor de 300MB.

Una vez se instalen el kernel genérico (`/bsd`) y los componentes que
eligió el instalador preparará el directorio `/dev` de dispositivos y
cambiará la partición de OpenBSD para que pueda arrancar el sistema en
caso de que sea la partición activa[^ins.2]. Puede entonces apagar con la
orden `halt -p`, retirar el CD y volver a iniciar para entrar al
sistema instalado. Si tienes problemas para ingresar a OpenBSD puede
arrancar con el CD de instalación y cuando este comenzando a cargar
expulsarlo para quedar en la linea de espera:

        boot>
              

En la que puede teclear `boot hd0a:bsd`

Si en su computador usa otro sistema operativo, ejecute el programa de
configuración de algún administrador de arranque para asegurarse de
permitir elegir OpenBSD o el otro o los otros sistemas que tenga (e.g
GRUB o LILO si también usa Linux ver [xref](#con-linux),
[XOSL](http://www.ranish.com/part/xosl.htm) si usa Windows 95/98/ME. Si
usa Windows NT o XP puede ser con el manejador de arranque de ese
sistema ver [xref](#con-windows-xp), si usa Windows Vista, 7, 8, 8.1 y 10 puede ser con EasyBCD).

Una vez ingrese verá `xdm` como se presenta a continuación (siempre y
cuando haya elegido iniciarlo durante la instalación y mientras su
tarjeta gráfico y monitor sean autodetectados).

![](img/instala6.png)

[^ins.1]: Si el disco tiene otras particiones del BIOS para otros sistemas,
    estos se verán con otras etiquetas (típicamente i para la primera
    partición Windows, m para la primera partición Linux).

[^ins.2]: Si no tiene un manejador de arranque, puede determinar cual de las
    4 particiones primarias es la activa con el programa `fdisk`.


## Instalación del resto de adJ {#instalacion-del-resto}

Tras instalar el sistema base y reiniciar su computador, puede ingresar
a la cuenta del usuario administrador que creó y puede completar la
instalación ejecutando desde una terminal:

        /inst-adJ.sh

Note que la J es mayúscula (en sistemas tipo Unix los nombres de 
archivos y programas son sensibles a la capitalización).

Este procedimiento permite instalar y actualizar adJ, así que puede
ejecutarlo cuantas veces lo requiera para completar la instalación o una
actualización. El archivo de ordenes `/inst-adJ.sh` lo guiará en la
instalación del resto del sistema con preguntas típicamente de si o no,
como se presenta en las siguientes capturas de pantalla de ejemplo: 

![](img/insadJ1.png)

![](img/insadJ2.png)

![](img/insadJ3.png)

adJ puede configurar por defecto 2 imágenes cifradas, una para almacenar
bases de datos de PostgreSQL (directorio `/var/postgresql`) y otra para
almacenar copias de respaldo de la base de datos y otros datos que usted
requiera (directorio `/var/www/resbase`). Cada una de estas imágenes
tienen asociadas claves para cifrar y descifrar, estas claves debe
suministrarlas típicamente durante el arranque o posteriormente
ejecutando:

        /etc/init.d/montaencpos
        /etc/init.d/montaencres

![](img/insadJ4.png)

![](img/insadJ5.png)

El servidor web nginx será configurado con SSL por lo que debe dar
detalles para el certificado como se presenta en la siguiente captura de
pantalla.

![](img/insadJ6.png)

![](img/insadJ7.png)

Después es recomendable que consulte `man afterboot` que incluye una
lista de chequeo de cosas por hacer después de la instalación https://man.openbsd.org/afterboot.

## Inicio del sistema {#inicio-del-sistema}

El arranque se realiza de acuerdo al archivo `/etc/rc` (que no debe
modificarse), este archivo en particular lee variables definidas por el
usuario en `/etc/rc.conf.local` donde puede especificar que servicios
desea iniciar durante el arranque. Un servicio es un programa que se
mantiene en operación mientras el computador está encendido, esperando
conexiones o requerimientos de programas o de otros servicios para
atenderlos, por ejemplo un servidor web es un servicio (que responde a
requerimientos de páginas web en cualquier momento que un usuario las
realice). `/etc/rc` también iniciará los servicios típicos del sistema y
algunos proveídos por paquetes y después ejecutará `/etc/rc.local`.

En el archivo `/etc/rc.conf.local` pueden definirse variables asociadas
a servicios (puede verse el listado de variables posibles para el
sistema base en `/etc/rc.conf`), si el valor de una variable es `NO` el
servicio relacionado no se activa, mientras que otro valor activa el
servicio y es pasado como parámetro (si no se desean parámetros
adicionales puede simplemente asignarse ""). Por ejemplo para iniciar
XDM en cada arranque:

        xdm_flags=""
        

Los servicios proveidos por paquetes que son iniciados se especifican en
la variable `pkg_scripts`, que se define en el archivo
`/etc/rc.conf.local`. Los servicios tanto del sistema base como de
paquetes típicamente tiene un archivo en el directorio `/etc/rc.d`.
Estos archivos de ordenes pueden ejecutarse con una de las siguientes
opciones (llamadas acciones):

`start`

:   Para iniciar el servicio.

`stop`

:   Para detener el servicio.

`check`

:   Para examinar el estado del servicio. Si retorna 0 significa que el
    servicio está operando, 1 de lo contrario.

`restart`

:   Detiene y vuelve a iniciar el servicio.

`reload`

:   Envía una señal al servicio para que vuelva a cargar sus archivos de
    configuración sin necesidad de detenerlo y volverlo a iniciar.


Otra forma de manejar servicios y sus variables (especificadas en 
`/etc/rc.conf.local`) es con `rcctl.` Esta herramienta maneja cada servicio
con 5 variables que indican como ejecutarlo: class (clase de login con la
que inicia), flags (opciones para iniciarlo), status (estado habilitado o no),
timeout (tiempo de espera para arranque), user (usuario que lo inicia).

Veamos ejemplos de su uso:

`doas rcctl enable cupsd`

:   Habilita un servicio disponible en `/etc/rc.d` de nombre `cupsd`. Alias
    de `doas rcctl set cupsd status on`

`doas rcctl disable cupsd`

:   Deshabilita un servicio disponible en `/etc/rc.d` de nombre `cupsd`. Alias
    de `doas rcctl set cupsd status off`

`doas rcctl -d restart cupsd`

:   Reinicia servicio cupsd presentado errores en la terminal si los hay, 
    en lugar `restart` también pueden usarse las acciones explicadas
    antes para archivos de ordenes del dirctorio `/etc/rc.d`.

`doas rcctl get cupsd`

:   Presenta las variables del servicio `cupsd` (también podría agregar una 
    variable al final si desea ver sólo una).

`doas rcctl getdef cupsd`

:   Presenta valor por omisión de las variables del servicio `cupsd` 
    (también podría agregar el nombre de una variable al final si desea 
     ver sólo una).

`doas rcctl set cupsd flags "-c /etc/cupsd2.conf"`

:   Establece la variable `flags` de servicio cupsd en `-c /etc/cupsd2.conf`
    es decir opciones especiales para el arranque. La variable
    `status` es especial porque sólo permite los valores on y off para
    habilitar o deshabiltiar el servicio respectivamente (agregándolo
    o quitándolo de pkg_scripts en `/etc/rc.conf.local`).

`doas rcctl ls on`

:   Presenta los servicios que están habilitados. En lugar de on
    también puede usarse `all` (todos), `failed` (los que fallaron),
    `off` (deshabiltiados), `started` (que están corriendo), 
    `stopped` (detenidos).
 
`doas rcctl order cupsd postgresql`

:   Pone primero los servicios `cupsd` y `postgresql` en `pkg_script`
    de forma que serán los primeros servicios en iniciar.
 

En adJ el archivo de ordenes `/etc/rc.local` además de poder contener
acciones por realizar en el arranque, permite reiniciar servicios que se
hayan detenido. Por esto tras detener un servicio (bien intencionalmente
o por error) puede ejecutar este archivo de ordenes para reiniciarlo
con:

        doas sh /etc/rc.local
              
## Configuración de Xorg {#configuracion-de-xorg}

Si durante la instalación eligió usar X-Window y xdm, e instaló los
juegos de instalación de X-Window (i.e `xbase&VER-OPENBSD-S;`,
`xfont&VER-OPENBSD-S;`, `xserv&VER-OPENBSD-S;`, `xshare&VER-OPENBSD-S;`), y si
su tarjeta fue correctamente configurada, al arrancar iniciará en el
ambiente gráfico.

Xorg puede también leer la configuración de su tarjeta de video,
monitor, teclado y ratón del archivo `/etc/X11/xorg.conf`, por lo que
este es el archivo que debe generar y configurar en caso de que la
autodetección de Xorg no opere con su hardware.

Si no logra ingresar al modo gráfico revise la bitácora de errores del
servidor X-Window con:

        doas less /var/log/Xorg.0.log

y edite el archivo de configuración, siguiendo las instrucciones de

        man xorg.conf 

hasta lograr que opere, puede editar por ejemplo con:

        doas mg /etc/X11/xorg.conf

Una vez le funciona (entra a modo gráfico del cual puede salir con
Ctrl-Alt-BackSpace) 
ejecutando

        doas xdm
        

Si persisten sus dificultades, puede buscar en Internet una
configuración correcta o solicitar el archivo de configuración a alguien
que le funcione o enviar la bitácora `/var/log/Xorg.0.log` a un grupo de
usuarios. Unos cambios que suelen funcionar son:

1.  Si en la bitácora `/var/log/Xorg.0.log` se recomienda, agregar

            machdep.allowaperture=2
                    

    o bien

            machdep.allowaperture=1
            

    hagalo en `/etc/sysctl.conf`, según lo recomendado en la bitácora.

    Elegir un monitor y editar el archivo para quitar el comentario que
    deja en la frecuencia horizontal --es decir el símbolo \# al
    comienzo de la línea.

2.  Escoger `vesa` como controlador y tarjeta de video.

3. En casos extremos puede comenzar con un archivo de configuración típico
  como el que se presenta a continuación (para teclado en español, tarjeta
  de video que soporta VESA, y un monitor que no requiere especificar
  rangos):

    Section "ServerLayout"
        Identifier     "X.org Configured"
        Screen      0  "Screen0" 0 0
        InputDevice    "Mouse0" "CorePointer"
        InputDevice    "Keyboard0" "CoreKeyboard"
    EndSection

    Section "Files"
    #   RgbPath      "/usr/X11R6/share/X11/rgb"
    #   ModulePath   "/usr/X11R6/lib/modules"
        FontPath     "/usr/X11R6/lib/X11/fonts/misc/"
        FontPath     "/usr/X11R6/lib/X11/fonts/TTF/"
        FontPath     "/usr/X11R6/lib/X11/fonts/Type1/"
        FontPath     "/usr/X11R6/lib/X11/fonts/CID/"
        FontPath     "/usr/X11R6/lib/X11/fonts/75dpi/"
        FontPath     "/usr/X11R6/lib/X11/fonts/100dpi/"
        FontPath     "/usr/local/lib/X11/fonts/local/"
        FontPath     "/usr/local/lib/X11/fonts/Speedo/"
        FontPath     "/usr/local/lib/X11/fonts/TrueType/"
        FontPath     "/usr/local/lib/X11/fonts/freefont/"
    EndSection

    Section "Module"
        Load  "dbe"
        Load  "freetype"
    EndSection

    Section "InputDevice"
        Identifier  "Keyboard0"
        Driver      "kbd"
        Option      "XkbLayout" "es"
        # Si el teclado fuera latinoamericano en vez de "es" usar "latam"
        Option      "XkbModel" "pc105"
    EndSection

    Section "InputDevice"
        Identifier  "Mouse0"
        Driver      "mouse"
        Option      "Protocol" "wsmouse"
        Option      "Device" "/dev/wsmouse"
        # Si es serial usar protocolo "Microsoft" y dispositivo "/dev/tty00" 
        Option      "ZAxisMapping" "4 5"
    EndSection

    Section "Monitor"
    #       HorizSync    30.0 - 70.0
    #       VertRefresh  50.0 - 90.0
    # Puede funcionar quitar el comentario en HorizSync (vea /var/log/Xorg.0.log)
        Identifier   "Monitor0"
        Option      "DPMS"
    EndSection

    Section "Device"
        Identifier  "Card0"
        Driver      "vesa
    #   BusID       "PCI:0:1:0"
    EndSection

    Section "Screen"     
        Identifier "Screen0"
        Device     "Card0"
        Monitor    "Monitor0"
        DefaultDepth     16
        SubSection "Display"
            Viewport   0 0
            Depth     1
        EndSubSection
        SubSection "Display"
            Viewport   0 0
            Depth     4
        EndSubSection
        SubSection "Display"
            Viewport   0 0
            Depth     8
        EndSubSection
        SubSection "Display"
            Viewport   0 0
            Depth     15
        EndSubSection
        SubSection "Display"
            Viewport   0 0
            Depth     16
            Modes    "1024x768"
        EndSubSection
        SubSection "Display"
            Viewport   0 0
            Depth     24
        EndSubSection
    EndSection
        

En este ejemplo mire que en la sección del monitor, la línea `HorizSync`
está comentada (el símbolo \# al comienzo de la línea) por lo que no se
usa ese parámetro de configuración. De funcionar en su caso este archivo
iniciara en 1024 x 768 con colores de 16 bits, porque la profundidad de
color por defecto especificada es esa (`DefaultDepth 16`) y el primer
modo indica esa resolución (`Modes "1024x768"`).

Algunas tarjetas antiguas no son soportadas por Xorg pero si por el
servidor XFree86 3.3.6, que podrá encontrar en versiones de OpenBSD
anteriores a 3.7. Este último emplea normalmente el archivo de
configuración `/etc/XF86Config` que puede generarse con ayuda de
`XF86Setup` o bien en modo texto con `xf86config3`.

Para la configuración del ratón tenga en cuenta que los ratones PS/2 y
USB se usan con el protocolo `wsmouse`, dispositivo `/dev/wsmouse`,
mientas que diversos ratones seriales emplean el protocolo `Microsoft` y
uno de los dispositivos seriales `/dev/tty00` o `/dev/tty01`.

Una vez logre configurar Xorg puede activar el administrador de vistas
XDM permanentemente agregando la siguiente línea al archivo
`/etc/rc.conf.local` (creélo si no existe):

        xenodm_flags="" 

### Tipos de letra

Los tipos de letra para X-Window se mantienen en
`/usr/X11R6/lib/X11/fonts` en diversos formatos (por ejemplo PCF, SNF,
BDF, TTF). Podrá editar diversos formatos y crear nuevos tipos de letra
con el excelente editor `fontforge`.

Una secuencia típica para copiar una fuente PCF (tomada de la
documentación de Bochs 2.0.2) es:

        cp font/vga.pcf /usr/X11R6/lib/X11/fonts/misc
        compress /usr/X11R6/lib/X11/fonts/misc/vga.pcf
        mkfontdir /usr/X11R6/lib/X11/fonts/misc
        xset fp rehash
          

Para emplear un nuevo tipo de letra TrueType deber registrarla tanto con
el servidor X como con `fontconfig` así:

1.  Asegurar que la ruta de la fuente está en un `FontPath` de la
    sección `Files` de `/etc/X11/xorg.conf`. Por ejemplo si sus fuentes
    TTF están en `/usr/local/lib/X11/fonts/MisTTF/`:

            FontPath "/usr/local/lib/X11/fonts/MisTTF/"
            

2.  Genere archivos `fonts.dir` y `scale` en el directorio donde está la
    fuente:

            cd /usr/local/lib/X11/fonts/MisTTF
            /usr/X11R6/bin/mkfontscale
            /usr/X11R6/bin/mkfontdir
                          

3.  Aplicar cambios a sesión actual

            xset fp rehash
                          

4.  Editar `/etc/fonts/local.conf` para que sea de la forma:

        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "/etc/fonts/fonts.dtd">
        <fontconfig>
          <dir>/usr/local/lib/X11/fonts/MisTTF</dir>
        </fontconfig> 

5.  Regenerar cache de tipos de letra, ejecutando como usuario `root`:

            cd /usr/local/lib/X11/fonts/MisTTF
            /usr/X11R6/bin/fc-cache -v
            /usr/X11R6/bin/fc-cache -v
                          

Si eventualmente el nuevo tipo no queda en los archivos generados
(`fonts.dir`, `fonts.scale`) edítelos y agréguelo (el primer número en
estos archivos es la cantidad de tipos por lo que debe incrementarlo).

### Lecturas recomendadas y referencias {#lecturas-xorg}

-   Página man de `xorg.conf`

-   Hay detalles sobre la configuración de Xorg en OpenBSD en el archivo
    `/usr/X11R6/README`

-   El servidor de X-Window incluido en OpenBSD &VER-OPENBSD; soporta
    fuentes anti-aliasing y True Type. Puede consultar el procedimiento
    para instalar fuentes True Type en
    <http://www.openbsd.org/faq/truetype.html>.


