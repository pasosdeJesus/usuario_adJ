Instalación y configuración del sistema básico {#instalacion-y-configuracion-del-sistema-basico}
----------------------------------------------

Una vez pueda iniciar un medio con un instalador, el sistema reconocerá
las partes de su computador y esperará algunas respuestas de su parte,
como si desea instalar, actualizar o iniciar un interprete de comandos
para rescatar un sistema: También podrá elegir distribución del teclado,
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
En las capturas de pantalla de ejemplo hay un sólo disco duro que se
usará completo para OpenBSD, es decir tendrá una sóla partición del BIOS
que abarca todo el disco. De no usarse completo el instalador ingresará
al programa `fdisk` que le permitirá especificar la partición del BIOS
que destinará para OpenBSD (en `fdisk` el comando 'h' le presentará una
breve ayuda). Tras definir el área del disco dedicada a OpenBSD podrá
definir etiquetas o subparticiones para el área de OpenBSD con el
programa `disklabel`. Aunque hay un modo de autolocalización de las
subparticiones se recomienda que cree su propio esquema de
subparticiones dejando al menos 10GB para la partición donde estará
`/usr/local` y al menos 1.2GB para `/var`. El comando 'h' en `disklabel`
presenta una breve ayuda. En el ejemplo siguiente se crean 4
subparticiones, la primera (`a`) siempre debe ser para el sistema raíz
(/), la segunda (`b`) siempre debe ser área de intercambio o swap (es
indispensable tenerla o podrá tener problemas de memoria posteriormente
con algunas aplicaciones), la partición `c` representa la partición del
BIOS completa y no debe tocarse, la tercera (`d`) corresponderá a
`/home` y la cuarta (`e`) a `/var`[^1]. Note que con este esquema los
programas y sus datos estáticos (típicos de los directorios `/bin`,
`/sbin` y `/usr` quedarán en la subpartición `a`. Los datos de usuario
típicamente en `/home` quedarán en la subpartición `d`, y los datos
variables de los programas (e.g páginas web, bases de datos, bitácoras)
típicos de `/var` quedarán en la subpartición `e`. Note que de cada
subpartición debe especificar desplazamiento (i.e sector en el que
comienza) y tamaño (i.e cantidad de sectores que ocupa). Tenga en cuenta
que un sector es de 512bytes, así que aproximadamente 2'000.000 de
sectores corresponden a 1GB. En el ejemplo anterior / es de
aproximadamente 10GB, la partición de intercambio es de 500MB, /home de
1GB y /var aproximadamente de 2.1GB. Después de elegir subparticiones el
instalador formateará las subparticiones. Después podrá especificar la
ruta donde están los juegos de instalación (en el caso de la
distribución Aprendiendo de Jesús es `/`) y elegir los que instalará.
Podrá elegir entre:

bsd

:   Se trata del kernel genérico ya compilado para su plataforma

bsd.mp

:   El kernel con soporte para múltiples procesadores (SMP).

bsd.rd

:   El kernel pero que no usa dispositivos de almacenamiento sino un
    disco virtual en RAM (útil por ejemplo para hacer actualizaciones).

baseVER-OPENBSD-S

:   Que es indispensable, porque además de la jerarquía de directorios
    incluye: los programas de los directorios `/bin`, `/usr/bin`,
    `/sbin`, `/usr/libexec` y `/usr/sbin`; las librerías de `/usr/lib`,
    `/usr/libdata` ; información de `/usr/share` y de `/var`. Entre los
    programas y servicios auditados que incluye están: herramientas
    estándar de Unix, servidor web Apache, OpenSSH, NIS, CVS, sendmail,
    NTP, IPv6, autenticación con Kerberos, NFS, NAT, AMD, AFS, perl y
    algunas herramientas de desarrollo.

etcVER-OPENBSD-S

:   También indispensable en sistemas que se instalan por primera vez
    (aunque no necesariamente si se hace actualización). Incluye los
    archivos de configuración del directorio `/etc` e información
    complementaria de `/var`.

compVER-OPENBSD-S

:   Que incluye herramientas de desarrollo para Fortran, C y C++. Las
    librerías que estas requieren y la documentación de las llamadas al
    sistema y de las librerías.

manVER-OPENBSD-S

:   Que incluye documentación HTML, info y man de los programas y
    librerías de baseVER-OPENBSD-S.

gameVER-OPENBSD-S

:   Algunos juegos que se instalan en `/usr/games`

miscVER-OPENBSD-S

:   Que incluye información del directorio `/usr/share` como
    diccionarios y documentación complementaria.

xbaseVER-OPENBSD-S

:   Programas básicos de X-Window (`/usr/X11R6/bin`), librerías
    (`/usr/X11R6/lib`) y su documentación (`/usr/X11R6/man`).

xfontVER-OPENBSD-S

:   Tipos de letra para X-Window (`/usr/X11R6/lib/X11/fonts`), para
    diversas codificaciones e idiomas, en resoluciones 100ppp y 75ppp.

xservVER-OPENBSD-S

:   Servidores X-Window para diversas tarjetas de video, librerías para
    soportar fuentes y documentación.

xshareVER-OPENBSD-S

:   Encabezados y documentación complementaria de X-Window

siteVER-OPENBSD-S

:   Requerido para continuar la instalación y configuración de
    Aprendiendo de Jesús. En particular archivo de comandos
    `/usr/local/adJ/inst-adJ.sh` que deberá ejecutar como usuario
    administrador cuando haya reiniciado.

la instalación de los componentes indispensables (baseVER-OPENBSD-S y
etcVER-OPENBSD-S) requiere cerca de 100MB, y la instalación de todos
requiere alrededor de 300MB.

Una vez se instalen el kernel genérico (`/bsd`) y los componentes que
eligió el instalador preparará el directorio `/dev` de dispositivos y
cambiará la partición de OpenBSD para que pueda arrancar el sistema en
caso de que sea la partición activa[^2]. Puede entonces apagar con el
comando `halt -p`, retirar el CD y volver a iniciar para entrar al
sistema instalado. Si tienes problemas para ingresar a OpenBSD puede
arrancar con el CD de instalación y cuando este comenzando a cargar
expulsarlo para quedar en la linea de espera:

        boot>
              

En la que puede teclear `boot hd0a:bsd`

Si en su computador usa otro sistema operativo, ejecute el programa de
configuración de algún administrador de arranque para asegurarse de
permitir elegir OpenBSD o el otro o los otros sistemas que tenga (e.g
GRUB o LILO si también usa Linux ver [???](#con-linux),
[XOSL](http://www.ranish.com/part/xosl.htm) si usa Windows 95/98/ME. Si
usa Windows NT o XP puede ser con el manejador de arranque de ese
sistema ver [???](#con-windows-xp), si usa Windows Vista o 7 puede ser
con EasyBCD).

Una vez ingrese verá `xdm` como se presenta a continuación (siempre y
cuando haya elegido iniciarlo durante la instalación y mientras su
tarjeta gráfico y monitor sean autodetectados).

[^1]: Si el disco tiene otras particiones del BIOS para otros sistemas,
    estos se verán con otras etiquetas (típicamente i para la primera
    partición Windows, m para la primera partición Linux).

[^2]: Si no tiene un manejador de arranque, puede determinar cual de las
    4 particiones primarias es la activa con el programa `fdisk`.
