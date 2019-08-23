# Configuración y uso de algunos dispositivos y servicios {#conf-dispositivos}


## Reconocimiento de hardware durante el arranque {#hardware-arranque}

Durante el arranque el kernel detecta hardware usando diversos
controladores en cierto orden. El orden y los controladores que se usen
dependen de la configuración que se haya dado al kernel al compilarlo.
El orden típico configurado en el kernel genérico es:

-   Procesador, Memoria, BIOS

-   Discos duros, CDROM y unidades de disquete

-   Buses, Teclado, Dispositivos ISA

-   Puertos paralelos y seriales

-   Dispositivos ISA plug and play

La configuración de la mayoría de estos dispositivos puede ser
determinada por el controlador, pero con algunos dispositivos (e.g ISA,
ciertos teclados) el kernel incluye valores predeterminados que en
algunos casos pueden no corresponder al hardware o que por la forma de
detectar congelan el sistema completo. En tal caso, determine los
recursos que el dispositivo tiene configurados con jumpers o con
software (e.g IRQ, dirección de entrada salida base, DMA) y modifique
los valores que emplea el kernel de una de estas formas (en un caso
extremo puede tener que deshabilitar el dispositivo):

-   Arranque con __`boot -c`__ y cambie parámetros usados por los
    controladores antes de continuar con la detección automática de
    hardware. El cambio sólo durará mientras no reinicie el sistema,
    puede hacer el cambio durable por ejemplo con la orden:
    __`config -u`__.

-   Después de que su sistema haya iniciado modifique los recursos
    asignados por defecto del kernel con __`config -e -o /bsd.new /bsd`__

-   Recompile el kernel con una configuración apropiada.

### Modificación antes de arrancar {#modificacion-antes-de-arrancar}

Al arrancar, cuando esté en el prompt `boot>`, inicie con:

            boot> boot -c
          

Así entrará a un entorno interactivo, que le permite cambiar la
asignación de recursos predeterminada para algunos dispositivos. Por
ejemplo si tiene una tarjeta de red compatible NE2000 con dirección base
0x300 e IRQ 3, el controlador `ne` la asignará la interfaz `ne1` que por
defecto usa la dirección base 0x300 pero la IRQ 10. Desde el prompt que
`boot -c` produce ingrese:

            UKC> change ne1
          

puede ver otras ordenes disponibles con la orden `help`. Una vez
complete la configuración salga del entorno interactivo con `quit`, tras
esto el kernel continuará la detección pero usando los cambios que haya
hecho.

Una vez haya configurado los recursos que un controlador emplea para que
correspondan a los de un dispositivo y que su sistema esté operando,
puede hacer el cambio permanente usando:

        doas config -e -o /bsd.ne1 -u /bsd
          

que le permitirá al mismo entorno interactivo, que procurará detectar
los cambios que usted haya podido hacer durante el arranque, le
permitirá completarlos y cuando salga (con `quit`) escribirá un nuevo
kernel `/bsd.ne1` con la misma configuración de `/bsd` pero con sus
cambios aplicados.

Si no logra configurar algún dispositivo y esto hace que el sistema
completo se congele durante el arranque, puede requerir deshabilitar el
dispositivo (situación que es muy inusual).

### Lecturas recomendadas y referencias (hardware-arranque) {#hardware-arranque-lecturas}

-   Página del manual unix de autoconf8. `autoconf` determina el orden y
    los controladores que se usan para la detección automática de
    hardware.

-   Página del manual unix de boot\_config y de 8 donde se describen las
    ordenes aceptados por el entorno interactivo de configuración de
    dispositivos.

-   Puede encontrar más sobre la secuencia de arranque de OpenBSD por
    ejemplo en <http://dhobsd.pasosdeJesus.org/pres21abr2005/>


## Impresión {#impresion}

Para atender trabajos de impresión hay disponibles para Unix varios
sistemas: lpd, LPRng, CUPS, QPD. El más popular y el incluido en la
distribución básica de OpenBSD es `lpd` que además de poder llevar
cuentas de cada usuario, permite a varios computadores en red compartir
una misma impresora.

### Uso de una impresora ya configurada {#uso-impresora}

Aun cuando algunos programas ofrecen menús con una opción para imprimir,
prácticamente todos usan en últimas el programa `lpr` (o
`/usr/local/bin/lpr` si está usando CUPS) que se encarga de poner la
información que debe enviarse a la impresora en una cola de trabajos
pendientes [^imp.1], que es atendida automáticamente (i.e de ella se envían
trabajos pendientes cuando la impresora está disponible) por un
programa.

<!-- lpr
Nombre del programa empleado para poner una impresión más en su cola de
impresiones pendientes. -->

Cada impresora configurada tiene un nombre, la impresora por defecto se
llama `lp` [^imp.2].

Posiblemente su sistema esté configurado para permitir a `lpr` la
impresión de textos planos y documentos PostScript o PDF. Para programar
la impresión de un texto plano con nombre `tarea.txt` en la impresora
por defecto, puede emplear:

          lpr tarea.txt
        

o eventualmente para especificar una impresora diferente a `lp`, digamos
`imp2` use la opción `-P`:

          lpr -Pimp2 tarea.txt
        

Puede examinar la cola de sus impresiones pendientes con `lpq` que junto
con los nombres de las impresiones pendientes presentará un número que
la identifica. Tal número le permitirá cancelar una de sus tareas de
impresión pendiente, usándolo como parámetro de `lprm`.

<!-- lpq
Nombre del programa empleado para examinar la cola de sus impresiones
pendientes. -->

<!-- lprm
Nombre del programa empleado para eliminar una impresión de la cola de
impresiones pendientes. -->

Para imprimir gráficas y documentos con diversos tipos de letra o
colores, primero debe convertirse la información a secuencias de control
particulares de su impresora. Cómo de una impresora a otra varían los
secuencias de control, en sistemas tipo Unix con LPD suele emplearse
PostScript (que es un lenguaje apropiado para documentos por imprimir)
como formato común y se usan los filtros del programa Ghostscript para
traducir de PostScript al formato particular de su impresora [^imp.3]. Si se
usa CUPS es posible emplear controladores particulares para su impresora
y no depender de Ghostscript.

Ghostscript es un programa que puede leer documentos PostScript y PDF
[^imp.4] y presentarlos en una ventana de X-Window o transformarlos al
lenguaje particular de algunas impresoras. Por ejemplo para generar a
partir de un documento PostScript `s2.ps` la secuencia de caracteres
apropiada para una impresora LaserJet en el archivo `s2.lj` se usaría:

        gs -sDEVICE=laserjet -sOutputFile=s2.lj s2.ps -c quit       
          

O para imprimir directamente usando `lpr`, en lugar de `s2.lj` puede
usar `-sOutputFile=\|lpr`. Puede experimentar con este intérprete
tecleando `gs` y por ejemplo ingresando la siguiente secuencia de
instrucciones en lenguaje PostScript:

        100 100
        moveto
        200 200
        lineto
        stroke
          

gs
Nombre del programa con el que se inicia Ghostscript ---intérprete de
PostScript.

Para visualizar un documento PostScript o PDF puede emplear el programa
`gv` ---el cual se apoya en Ghostscript--- por ejemplo:

        gv micarta.ps
        

mostrará el documento PostScript `micarta.ps` en una ventana de X-Window
y con menús le permitirá consultarlo e imprimirlo.

gv
Programa empleado para visualizar documentos Postcript o PDF.

Para imprimir y hacer transformaciones a un PostScript (por ejemplo 2
páginas en una sola), o para convertir de otros formatos a PostScript
puede emplear el programa `a2ps`:

        a2ps ­­columns=2 -o micarta-2.ps micarta.ps
          

o `mpage`:

        mpage -2 micarta.ps > micarta-2.ps
          

a2ps
Programa para transformar de diversos formatos a PostScript o para hacer
transformaciones a un Postcript.

Además de los programas `a2ps` y del paquete `psutils` es posible
modificar directamente un archivo PostScript. Por ejemplo siguiendo las
indicaciones de
<http://www.ghostscript.com/pipermail/bug-gs/2001-August/000641.html>,
resulta posible rotar una página, editando el archivo y en la sección
`%%%BeginPageSetup` agregando después de establecer tamaño de página,
e.g. `595 842 /a4 setpagesize`:

        currentpagedevice /PageSize get aload pop translate
        180 rotate
        

Tanto PostScript como PDF requieren bastante espacio para describir un
documento, usualmente los documentos PDF requieren menos porque
mantienen la información comprimida. Para convertir entre PostScript y
PDF se emplean `ps2pdf` y `pdf2ps` [^imp.5]. Para visualizar e imprimir un
PDF, además de `gv`, puede emplear `xpdf` o el programa Acrobat Reader
(`acroread`).

<!-- xpdf
Programa empleado para consultar documentos PDF. -->

<!-- ps2pdf
Programa para transformar de PostScript a PDF. -->

<!-- pdf2ps
Programa para transformar de PDF a PostScript. -->

### Configuración de una impresora local con `lpd` {#lpd-local}

lpd (también llamado *Berkeley line printer spooling system*) es un
sistema que maneja una cola de impresión por cada impresora configurada,
filtros para convertir información de diversos tipos (e.g PostScript y
PDF) al lenguaje particular de cada impresora así como filtros de
cuentas que permiten monitorear y controlar el uso de cada impresora por
parte de cada usuario. LPD recibe y procesa solicitudes de impresión
realizadas por programas cliente e imprime la información de las colas
en los dispositivo configurados para cada cola (e.g `/dev/lpt0` o
enviando por red a una impresora remota).

En OpenBSD lpd debe activarse durante el arranque, agregando en
`/etc/rc.conf.local` la línea:

        lpd_flags="" 

su archivo de configuración principal es `/etc/printcap` el cual es
leído cada vez que lpd inicia y donde se configura cada cola de
impresión, el dispositivo asociado a cada una y sus parámetros, los
filtros para los diversos tipos de información que puede imprimir y
filtros de cuentas.

lpd es un servidor TCP/IP que imprime trabajos pendientes en las colas
de impresoras locales (sólo modificables con programas clientes) y que
atiende conexiones de clientes que emplean el protocolo LPD en el puerto
TCP 515. La conexión normalmente la realiza un programa cliente como
`lpr`, `lpq`, `lprm` o `lpc` que pueden solicitar una de las siguientes
operaciones:

-   Revisar trabajos en cola de una impresora.

-   Recibir y poner en cola de una impresora un trabajo de otra máquina.

-   Listado corto del estado de los trabajos de un usuario en la cola de
    una impresora.

-   Listado largo del estado de los trabajos de un usuario en la cola de
    una impresora.

-   Eliminar trabajos de un usuario de la cola de una impresora

`lpd` envía errores a la bitácora `/var/log/lpd-errs`.

lpd
Nombre del servidor de impresión disponible por defecto en OpenBSD.
Permite manejar colas, dispositivos de impresión, filtros y puede llevar
cuentas.

Además de esta documentación puede consultar más sobre la configuración
de `lpd` en FreeBSDHandBook y OpenBSDlpd

/dev/lpt0
Dispositivo que representa el primero puerto paralelo.

La mayoría de impresoras se conectan al puerto paralelo (por ejemplo
utilizables con dispositivos `/dev/lpt0` o `/dev/lpt1`). Puede probar
que su impresora funciona enviando una cadena sencilla al puerto
apropiado por ejemplo `echo "Hola"
      >/dev/lpt0` o `lptest >
      /dev/lpt0`.

/etc/printcap
Archivo donde se configuran impresoras para el sistema `lpd`.

El siguiente es un ejemplo del archivo `/etc/printcap`:

          lp|local line printer:\
          :lp=/dev/lpt0:sd=/var/spool/output:lf=/var/log/lpd-errs:
        

que configura una impresora local para textos llamada `lp` o
`local line printer`. Está conectada a `/dev/lpt0`, la cola de impresión
la mantiene en `/var/spool/output` y envia errores a
`/var/log/lpd-errs`. Para configurar impresoras que puedan imprimir
gráficas (así como PostScript con diversos tipos de letra) debe emplear
un filtro del programa Ghostscript.

### CUPS

#### Instalación {#cups-inst}

Hay un paquete de CUPS entre los portes oficiales de OpenBSD
&VER-OPENBSD;. Una vez instalado puede ejecutarlo con

        doas cupsd
        

Para que en cada arranque se ejecute automáticamente, se recomienda
agregar en `rc.local`:

        if (test -x /usr/local/sbin/cupsd) then {
            echo -n ' cupsd';
            /usr/local/sbin/cupsd;
        } fi;
        

La distribución estándar de cups incluye unos pocos archivos `ppd`, así
que posiblemente tendrá que generar o conseguir los apropiados para su
impresora con `foomatic` (ver [foomatic](#foomatic)).

#### Configuración {#cups-conf}

La configuración de CUPS (por ejemplo para añadir una impresora) puede
hacerse con facilidad una vez esté ejecutándose el servidor, usando un
navegador y abriendo en la máquina donde corre CUPS el puerto 631, por
ejemplo `http://127.0.0.1:631`. Para hacer labores administrativas
ingrese con la identificación y la clave de un usuario que esté en el
grupo `sys` o por la cuenta `root`.

También es recomendable que cree un directorio:

        doas mkdir /var/spool/cups/tmp
        doas chown _cups:_cups /var/spool/cups/tmp/
        

Si tiene problemas al instalar/usar una impresora puede consultar el
archivo de errores de `cups` en: `/var/log/cups/error_log`.

#### Utilización de CUPS {#uso-cups}

El paquete de `cups` cuenta con programas análogos a los de LPD, pero
ubicados en `/usr/local/bin`. Diversos programas emplearan la orden
`lpr` para hacer impresiones, así que tiene dos opciones:

-   Ejecutar `cups-enable` que remplazará los ejecutables relacionados
    con impresión de `/usr/` con los de CUPS disponibles en
    `/usr/local/`.

-   Configurar cada programa para que en lugar de emplear `/usr/bin/lpr`
    utilice `/usr/local/bin/lpr`. Por ejemplo así debe configurar xpdf.

### foomatic

`foomatic` ofrece gran cantidad de controladores para una variada gama
de impresoras, estos controladores e instrucciones para impresoras
particulares están disponibles en <http://www.openprinting.org> Es
posible emplearlos bien con `lpr` o bien con `cups`.

#### Foomatic con LPR {#foomatic-lpr}

Si la impresora está conectada a `/dev/lpt0` basta que
agregue a `/etc/printcap` una entrada como:

    lp|local line printer:\
        :lp=/dev/lpt0:\
            :af=/etc/foomatic/laserjet6p.ppd:\
            :if=/usr/local/bin/foomatic-rip:\
            :sd=/var/spool/lpd:\
            :lf=/var/log/lpd-errs:\
            :mx#0:sh:

#### Foomatic con CUPS {#foomatic-cups}

Cada archivo `ppd` que descargue debe ubicarlo en:
`/usr/local/share/cups/model/`. Después de agregar archivos en ese
directorio reinicie CUPS para que lea nuevamente sus archivos de
configuración con:

    # pkill -HUP cupsd
                  

[^imp.1]: En el caso de LPD el directorio con la cola de trabajos de una
    impresora se configura en `/etc/printcap`, en el caso de `lp` el
    directorio por defecto es `/var/spool/outputlpd/lp`.

[^imp.2]: Normalmente puede configurar otro nombre para la impresora por
    defecto en la variable de ambiente PRINTER.

[^imp.3]: Hay algunas impresoras que pueden imprimir PostScript
    directamente, pero en general para hacer la traducción de PostScript
    al lenguaje de una impresora se requiere un filtro que el
    administrador del sistema debe configurar.

[^imp.4]: PDF (*Portable Document Format* es otro lenguaje para impresión,
    de documentos con gráficas y diversos tipos de letras, basado en
    PostScript (de la misma compañía ---Adobe).

[^imp.5]: De acuerdo a Printig-HOWTO estas herramientas ofrecen la
    funcionalidad de las herramientas "*distiller*" de Adobe.

## Discos duros

En la actualidad hay discos de estado sólido y discos electromecánicos.  

Los discos SSD mantienen información de manera permanente mediante circuitos integrados.

Los discos electromecánicos constan de varias placas circulares sobre las que se almacena información magneticamente. La organización o geometría de un disco suele especificarse como cantidad de cilindros (del ingleś *cylinder*), cantidad de cabezas (del inglés *head*) y cantidad de sectores. 
Para poder emplear un disco se requiere un controlador que lo maneje, el disco debe estar formateado a bajo nivel, debe estar particionado, una o más particiones deben tener tipo para adJ/OpenBSD (tipo A6), y esas particiones deben tener etiquetas con subparticiones (del inglés *disklabels*) con el sistema de archivos FFS para poder montarlas.

Además de esto para iniciar un computador con un disco duro, debe estar configurado como disco de arranque en la BIOS (o durante el arranue indicarle a la BIOS por cual disco arrancar). debe tener una partición marcada como iniciable en la tabla de particiones o debe emplear un cargador de arranque (e.g LILO o GRUB).

Todo disco duro cuya interfaz sea soportada por Linux debe funcionar sin requerir configuración manual. Debian 2.2 incluye estaticamente controladores para interfaces de discos RLL, MFM diversos IDE/EIDE y tiene módulos para diversos discos SCSI, así como módulos para discos conectados a puerto paralelo (ver Puerto paralelo) y controladores para arreglos de de discos RAID (0,1,4/5) ---para respaldar información [169].

### Particiones {#particiones-slices}

Una partición es una porción de un disco duro destinada para un sistema de archivos. Un disco duro puede particionarese para:

Mantener varios sistemas operativos.

Destinar varias particiones a Linux montando cada partición como un directorio (y limitando así el espacio de esos directorios), por ejemplo /var (donde está la cola de correo), /usr donde se ubican programas, /home donde cada usuario tiene su espacio personal (ver Ubicación de archivos y directorios).

Destinar alguna partición como zona de intercambio (swap) para emplear espacio de disco como si fuera memoria RAM.

Destinar alguna partición al directorio /boot para facilitar el arranque de Linux en algunos computadores con discos duros de más de 1024 cilindros, como se explica a continuación.

La división en particiones de un disco duro se mantiene en una tabla de particiones que está en el primer sector físico, que además puede tener un cargador de arranque (ver Inicialización del sistema).

Linux en un PC puede manejar a lo sumo 4 particiones primarias (en el caso de un disco IDE las particiones primarias están asociadas a los dispositivos /dev/hda1, /dev/hda2, /dev/hda3 y /dev/hda4). Dado que pueden requerirse más de 4, una de las particones primarias puede remplazarse por una partición extendida, y tal partición extendida puede entonces dividirse en una o más particiones lógicas (que en el caso de un disco IDE primario se referencian como /dev/hda5, /dev/hda6, y así sucesivamente).

Para la operación de Debian se requiere al menos una partición de 300MB (o de 800MB para un sistema básico o 2GB para una instalación completa), aunque consideramos recomendable al menos una partición más para swap (memoria virtual [170]) de un tamaño cercano a la cantidad de RAM del computador. En los casos de un servidor o un cliente para una red en un colegio lo invitamos a consultar nuestra sugerencia para la división del espacio en particiones Ver Plataforma de referencia.

Aunque en un mismo disco duro pueden dejarse diversos sistemas operativos, por razones históricas, con diversas BIOS (previas a 1998 o que no soporten LBA32) es indispensable dejar el arranque de cada sistema operativo en los primeros 1024 cilindros. Para facilitar esto, en caso de requerirse, el arranque básico de Linux (directorio /boot) puede dejarse en una partición pequeña (e.g 10MB) en los primeros 1024 cilindros o incluso como un directorio en DOS, mientras que el resto del sistema puede estar en una o más particiones en cualquier ubicación del disco.

Para cambiar la tabla de particiones de un disco en Linux pueden emplearse los programas cfdisk o fdisk [171]. Ambos se inician pasando como parámetro el dispositivo del disco que desea editar (e.g /dev/hda o /dev/sda), le permiten modificar la partición hasta que este satisfecho con la distribución y finalmente permiten salvar la partición configurada en el disco.

[Warning]	Aviso
Al modificar una partición el sistema de archivos que en ella hubiera no podrá usarse, es muy recomendable que mantenga en un escrito la tabla de particiones de su disco incluyendo tipo, inicio y fin de cada una para recuperarla de requerirse.
Hay dos niveles de particiones: (1) del BIOS y (2) particulares de
OpenBSD. Las primeras se configuran con `fdisk` y las segundas se crean
dentro de las primeras con `disklabel`.

### Sistema de archivos ffs

Un sistema de archivos ffs sólo puede crearse en una partición
identificada con `disklabel`. Como se explica en FFS, consta de:

-   Un superbloque con los parámetros básicos del sistema de archivos
    (e.g tamaño de cada bloque, lista de grupos de cilindros) y con los
    parámetros del hardware que afectan el desempeño[^dis.1] (tipo de
    transferencia de disco a memoria, tiempo esperado por transferencia,
    bloques por pista, velocidad de rotación).

-   Copias de seguridad del superbloque en diversos bloques del disco.

-   Archivos, algunos de los cuales pueden ser directorios. Todo archivo
    tiene asociado un nodo-i, que mantiene información del archivo
    (dueño, tiempo de última modificación y de creación, algunos de los
    bloques que emplea el archivo y referencia a otros nodos-i con el
    resto de bloques).

Los bloques pueden fragmentarse para aprovechar espacio cuando se
mantienen archivos pequeños. Cada grupo de cilindros tiene una tabla de
fragmentos libres en los bloques del grupo e información sobre bloques
libres de acuerdo a las diversas posiciones rotacionales (para optimizar
ubicación de información de acuerdo al hardware disponible).

Algunos bloques se reservan para que sólo puedan ser usados por el
administrador (reserva de espacio libre). En OpenBSD por defecto es 5%
del espacio total.

Entre las características soportadas por FFS están:

-   Enlaces duros dentro de una misma partición o enlaces simbólicos.
    Candados, nombres largos para archivos, validaciones y cuotas (para
    limitar espacio utilizable por los usuarios).

Para revisar un sistema de archivos `ffs` (digamos que esté en la
partición `/dev/wd1j`) ejecute:

        doas fsck_ffs /dev/rwd1j
          

note la `r` antes de `wd1j` que indica que la partición debe tratarse en
modo puro (del inglés *raw*). Puede agregar la opción `-y` antes del
dispositivo para responder si por defecto a toda pregunta (intentado que
solucione automáticamente todos los problemas). En algunos casos cuando
un disco está bastante inconsistente en su estructura, puede perderse
información que `fsck_ffs` intentará recuperar y dejar en archivos cuyos
nombres son números en el directorio `lost+found`. En los casos que se
dañe el superbloque de la partición que desea revisar `fsck_ffs` se
negará a realizar el chequeo, en tales casos puede intentar con un
superbloque de respaldo --típicamente hay uno en el bloque 32:

        doas fsck_ffs -b 32 /dev/rwd1j
          

Para crear un sistema de archivos `ffs` en un disco ya particionado con
`disklabel` puede emplearse `newfs`, por ejemplo:

        doas newfs -t ffs /dev/wd1j

> ![](img/warning.png) **Advertencia**
>
> Al crear un nuevo sistema de archivos se borra la información que
> pudiera haber existido.

Para detectar particiones ffs en un disco, puede emplearse `scan_ffs`.

Para examinar la estructura de una partición con ffs, se emplea
`dumpfs`. Puede afinarse un sistema ffs con `tunefs`

### Zonas de intercambio (swap) {#zonas-de-intercambio}

Son porciones de un disco duro que pueden emplearse como si fuera
memoria RAM (aunque es mucho más lenta). Si por ejemplo desea agregar
como dispositivo de intercambio el disco `/dev/wd1l` debe:

1.  Asegurarse de poner tipo swap a la partición. Puede emplear
    `disklabel`. Por ejemplo puede emplear el modo interactivo de este
    programa:

            doas disklabel -E /dev/wd1c 

    en este modo puede examinar las particiones y divisiones del disco
    con p, puede ver una ayuda abreviada con h. Con m le será posible
    cambiar el tipo de una partición (por ejemplo puede ser `4.2BSD` si
    se trata de un sistema ffs o `swap` si se trata de un dispositivo
    para intercambio), y la ubicación.

    > ![](img/caution.png) **Cuidado**
    >
    > El sitio donde reubique una partición NO debe estar traslapado
    > sobre una partición ya existente. Si traslapa una partición sobre
    > otra, la información que hubiera en la partición sobre la que
    > traslapa puede perderse de manera irreversible.

2.  Agregue una línea a su archivo `/etc/fstab` con el dispositivo de
    intercambio, punto de montaje `none`, tipo `swap` y opción `sw`:

            /dev/wd1l none  swap sw 0 0 

    Con este cambio, el dispositivo será montado como zona de
    intercambio cada vez que el sistema inicie (está en `/etc/rc`).

3.  Intente agregar el dispositivo como zona de intercambio sin
    reiniciar con:

            doas swapon -a 

    o con:

            doas swapctl -A -t blk 

    Ambas ordenes intentarán montar como zonas de intercambio todos
    dispositivos por bloques de `/etc/fstab` que tengan la opción `sw`.
    Puede verificar la adición listando todas las zonas de intercambio
    con:

            doas swapctl -l 

[^dis.1]: Los parámetros del hardware mantenidos ayudan a localizar bloques
    libres de forma óptima.

### Arreglo de discos RAID por software {#raid}

Cómo se explica en la página del manual de `softraid`, OpenBSD incluye 
el dispositivo `softraid` que puede proveer RAID y otros 
servicios relacionados con entrada/salida.  
Un volumen es un disco virtual que consta de varios "pedazos", cada "pedazo" 
(del inglés __chunk__) es una subpartición del disco de tipo RAID (el
tipo se establece con `disklabel`).

Las posibles disciplinas que soporta `softraid` son:

* RAID 0:  Que segmenta los datos sobre un número de "pedazos" para
	aumentar el desempeño (aunque no provee redundancia).  No
	es posible hacer volumenes de arranque.
* RAID 1: Copia cada dato en más de un "pedazo" para facilitar
  	recuperar información en caso de perdida de datos.  Si es
	posible hacer volúmenes de arranque.
* RAID 5: Divide los datos en varios pedazos pero proveen paridad
 	para prevenir perdida de datos.  No es posible hacer volumenes
	de arranque.
* CRYPTO: Cifra los datos en un sólo pedazo para proveer
	confidencialidad (aunque no redundancia). Si es posible hacer
	volumenes de arranque.
* CONCAT: Que concatena varios pedazos, aunque no provee redundancia ni
	permite hacer volumenes de arranque.

Hemos notado en la práctica que cada "pedazo" debe ser máximo de 2T.

#### RAID 1 sin arranque

La disciplina RAID 1 provee redundancia, pues cada dato lo escribe en 
todos los pedazos que conforman el arreglo.  Así que cada pedazo es 
como una copia de cada uno de los otros. 

Para el caso típico de 2 "pedazos" que se configurarán en RAID 1 pero no
como volumen de arranque, se recomienda usar 3 discos duros.
Uno para arrancar (digamos sd0) y 2 de las mismas dimensiones que se 
configuraran en RAID 1 (digamos sd1 y sd2 cada uno de 2T).

sd0 debe tener un sistema OpenBSD/adJ típico para (1) configurar
el RAID 1 para sd1 y sd2 y (2) montar el arreglo resultante
en un directorio de su sistema de archivos.

Primero se preparan sd1 y sd2 completos para OpenBSD (o si es una parte de
cada uno usar -e)

		doas fdisk -iy sd1
		doas fdisk -iy sd2

Después en cada uno se crea una subpartición de tipo RAID con disklabel, 
ambas deben quedar del mismo tamaño y se recomienda inicializarlas
en ceros:

		$ doas disklabel -E sd1
		Label editor (enter '?' for help at any prompt)
		> a a
		offset: [64]
		size: [39825135] *
		FS type: [4.2BSD] RAID
		> w
		> q
		$ doas dd if=/dev/zero of=/dev/rsd1a bs=1m count=1

En el ejemplo anterior se presentó el caso de creación de sd1a, debe repetirse 
lo mismo para sd2 para contar con sd2a.

A continuación debe ensamblarse el arreglo RAID con algo como:

		doas bioctl -v -c 1 -l sd1a,sd2a softraid0

Que creará otro dispositivo, digamos sd3 (aún si necesita hacer varios 
arreglos RAID emplee siempre softraid0).  Puede verificar que sd3 es el 
arreglo RAID con:
	
		$ doas bioctl sd3
		Volume Status Size Device 
		softraid0 0 Online 3298542608896 sd3 RAID1 
		0 Online 3298542608896 0:0.0 noencl 
		1 Online 3298542608896 0:1.0 noencl

Con el arreglo ensamblado en sd3, usted puede operar con ese dispositivo 
como si fuera un disco más, es recomendable que inicialice sus primeros 
sectores en 0:

		doas dd if=/dev/zero of=/dev/rsd3c bs=1m count=1

Y proceda a crear partición,  subpartición(es) e inicializar cada 
subpartición. En el siguiente ejemplo se creará una sola subpartición,
se inicializará y se montará en /var/raid1:

		$ doas fdisk -iy /dev/rsd3c
		$ doas disklabel -E /dev/sd3c
		> a a
		offset: [64]
		size: [3999992128] *
		FS type: [4.2BSD] 
		> w
		> q
		$ doas newfs /dev/rsd3a
		$ doas mkdir /var/raid1
		$ doas mount /dev/sd3a /var/raid1

Con el ejemplo presentado ya habrían disponibles 2T con redundancia RAID 1 
en el punto de montaje /var/raid1.

Para hacer el cambio permanente es recomendable que en /etc/fstab
agregue el duid del arreglo (pues al agregar discos físicos podría
cambiar el sd3 por ejemplo por sd4).  Examina el duid con 
		disklabel /dev/sd3c


##### Operación y recuperación en caso de falla de uno de los discos

Es importante revisar con periodicidad el estado del arreglo con:

		$ doas bioctl sd3

Allí podría verse si alguno de los discos está fallando (Offline) y en
tal caso, debe remplazarse el disco defectuso (digamos sd2).  En el nuevo 
disco debe crearse partición y subpartición con las mismas características 
del que funciona bien y entonces debe reconstruirse el espejo.
Por ejemplo para reconstruir y unir un nuevo /dev/sd2a:

		$ doas bioctl -R /dev/sd2a sd3


#### Lecturas recomendadas y referencias RAID

-  Página del manual de `softraid`

-  Página del manual de `bioctl`

-  <https://www.openbsd.org/faq/faq14.html>


## Disquetes e imágenes de disquetes {#disquetes-e-imagenes-de-disquetes}

### Programas del paquete `mtools` {#mtools}

El usuario root podrá leer disquetes con las herramientas del paquete
mtools, por ejemplo para ver el contenido de un disquete y después
copiar del disquete al directorio actual el archivo `cart.txt`:

        mdir
        mcopy a:cart.txt .  

Para escribir todos los archivos con extensión `tgz` en el disquete de
la primera unidad:

        mcopy *tgz a: 

En OpenBSD por omisión sólo `root` puede montar y escribir disquetes.
Puede lograrse que las herramientas de mtools escriban en disquetes
cuando son ejecutadas desde una cuenta que pertenezca al grupo
`operator` cambiando permisos de algunos archivos:

        chmod g+xwr /dev/rfd* /dev/fd*
            

Si no desea cambiar permisos de dispositivos, ni manejar el grupo
`operator` ni cambiar variables del kernel puede configurar y emplear
`doas` (ver [doas](#doas)):

        doas mcopy *tgz a: 

o incluso con `doas` y un alias hacer transparente la restricción para
los usuarios que puedan emplear `doas`:

        alias mcopy='doas mcopy' 

### Montar disquettes en jerarquía de directorios {#montar-disquettes}

Desde la cuenta `root` podrá montar disquettes de manera directa.

Para montar disquettes desde cuentas de usuarios que pertenezcan al
grupo `operator` puede cambiar la variable de configuración del kernel
`kern.usermount`, bien de forma permanente en `/etc/sysctl.conf` o bien
en una sesión con:

        sysctl -w kern.usermount=1          
            

Por ejemplo para montar el disquete de la primera unidad en el
directorio `/mnt/floppy` (el cual debió crear antes):

        mount -t msdos /dev/fd0c /mnt/floppy 

o cree una entrada apropiada en `/etc/fstab`:

        /dev/fd0c /mnt/floppy msdos rw,noauto 0 0 

tras lo cual basta:

        mount /mnt/floppy 

Tenga en cuenta que después de terminar todas las operaciones con el
disquette debe desmontarlo con:

        umount /mnt/floppy
        

### Montar imagenes de disquettes {#montar-imagenes-disquettes}

Puede montar imágenes de disquetes creando primero un dispositivo con
`vnconfing` asociado con la imagen y después montar tal dispositivo en
el directorio deseado. Vea la forma análoga de lograrlo con CDs en
[xref](#cd).


## Unidad de CD-ROM {#cd}

### Montar un CD {#montar-cd}

Cómo en el caso de disquetes, por defecto, sólo root puede montar CDs.
Puede permitir que se haga desde una cuenta diferente, agregando tal
cuenta al grupo `operator` y cambiando la variable del kernel
`kern.usermount` como se presentó en la sección sobre disquettes. Por
ejemplo para montar el CD que está en la primera unidad (después de
haber creado el directorio `/mnt/cdrom`):

        mount -t cd9660 /dev/cd0c /mnt/cdrom 

o para lograrlo con sólo `mount /mnt/cdrom` se agregaría en
`/etc/fstab`:

        /dev/cd0c /mnt/cdrom cd9660 ro,noauto 0 0 

Para desmontar un CD se emplea:

        umount /mnt/cdrom

### Montar imagen ISO 9660 {#montar-imagen-iso}

Para montar una imágen ISO (i.e un archivo con información de un CD con
el sistema de archivos ISO 9660), primero debe crear un dispositivo que
la represente, por ejemplo:

        vnconfig -c vnd0 /home/&EUSUARIO;/micd.iso 
        mount /dev/vnd0a /mnt/tmp
        

### Lecturas recomendadas y referencias CD y Quemadoras {#referencias-cd-y-quemadoras}

-   Más sobre montaje de archivos con `man fstab`.


## Quemadora de CD-R y CD-RW {#quemadora}

Una quemadora de CD-R y CD-RW se puede comportar como un lector de CDs y
usarse como se explica en la sección sobre unidades de CD (ver
[xref](#cd).

Para quemar una imagen de un CD con datos que usted elija se debe:

-   Contar con una imagen ISO del CD que desea quemar. Es decir un
    archivo con la información que irá en el CD en formato ISO9660. Tal
    imagen la puede crear a partir de un CD que tenga o crearla con
    archivos y directorios que usted elija.

-   Grabar (o quemar) la imagen ISO en un CD-R o un CD-RW.

Cada uno de estos pasos se describe en detalle a continuación.

### Crear una imagen ISO a partir de un CD existente {#crear-imagen-de-cd}

Para crear una imagen ISO de un CD existente primero examine la cantidad
de sectores de los que consta con

        doas disklabel /dev/rcd0c
          

Suponiendo que cada sector tenga 2048 bytes y el total de sectores fuera
112120 puede crear la imagen (`/home/imagen/micd.iso`) empleando la
orden:

        doas dd if=/dev/rcd0c of=/home/imagen/micd.iso bs=2048 count=112120
          

### Crear una imagen nueva ISO 9660 {#crear-nueva-imagen-iso}

Para crear una imagen ISO a partir de datos que usted elija, deje los
archivos y directorios por incluir en un directorio (digamos
`/home/&EUSUARIO;/imagen`), el cual después puede especificarse a
`mkisofs` (programa que hace parte del paquete `cdrtools`). El formato
estándar para salvar información en CD-ROMs (ISO9660) sólo permite
nombres de archivos con 8 caracteres, extensiones de 3 y restricciones
en la codificación de caracteres, hay algunas extensiones que permiten
aumentar este margen, una de estas que es algo portable es Rock Ridge
(funciona al menos en sistemas Unix y en Windows).

Para crear una imagen ISO con nombre `/home/&EUSUARIO;/micd.iso` a partir
de la información disponible en `/home/&EUSUARIO;/imagen` puede ejecutar
como usuario `root`:

        cd /home/&EUSUARIO;/imagen
        doas mkisofs -r -l -f -o /home/&EUSUARIO;/micd.iso  .
        

Note que la imagen creada emplea la extensión Rock Ridge (opción `-r`),
permite nombres largos (opción `-l`) y maneja enlaces simbólicos (opción
`-f`).

Por otra parte en sistemas i386 o amd64 es posible arrancar un
computador desde un CD, configurando el arranque del computador desde el
BIOS para que sea por la unidad y cuando la imagen del CD se crea con la
extensión El Torito. La extensión El Torito permite incluir la imágen de
un floppy que se usa para arrancar.

Para crear una imágen ISO que use extensión Rock Ridge, con una tabla de
contenido de cada directorio (`TRANS.TBL`), que emplee la imágen de
disquete `floppy.img` para arrancar, con información de derechos de
reproducción del archivo `/home/&EUSUARIO;/Derechos.txt`, siguiendo
enlaces simbólicos y con la jerarquía de directorios y archivos de
`/home/&EUSUARIO;/imagen/` (en la que no debe existir el archivo
`boot.catalog`) use:

        cd /home/&EUSUARIO;/imagen
        doas mkisofs -b floppy.img -c boot.catalog -copyright /home/&EUSUARIO;/Derechos.txt \
          -r -l -f -o /home/&EUSUARIO;/micd.iso  .
        

### Quemado de una imagen ISO 9660 en un CD-R o en un CD-RW {#quemar-imagen-iso}

Para escribir una imágen ISO (`micd.iso`) con datos en un CD-R, puede
emplear el programa `cdrecord`, el cual puede emplear como dispositivo
uno de la forma `/dev/cd0c` o bien `/dev/rcd0c:0,0,0`, por ejemplo:

        doas cdrecord dev=/dev/cd0c -data speed=16 /home/&EUSUARIO;/micd.iso
        

Si emplea un CD-RW tenga en cuenta blanquearlo antes de escribir usando
la opción `blank=fast`:

        doas cdrecord dev=/dev/cd0c -data blank=fast speed=16 /home/&EUSUARIO;/micd.iso
        

Si desea emplear varias sesiones en un mismo CD-R (o CD-RW) tenga en
cuenta:

-   La primera sesión se hace creando una imágen ISO usual y al quemar
    con cdrecord agregue la opción `-multi`.

-   Las imágenes de sesiones posteriores deben crearse empleando la
    opción `-C` de `mkisofs` [^que.1]. Los datos precisos que debe pasar a
    la opción -C los examina con:

            doas cdrecord dev=/dev/cd0c -msinfo

    Que retorna un par de números (supongamos que 18904,26106), los
    cuales debe usar con mkisofs, por ejemplo:

            doas mkisofs -r -l -f -C 18904,26106 -o ../micd.iso .

    Y nuevamente debe pasar la opción `-multi` a `cdrecord` en el
    momento de quemar.

Para crear CDs de audio deben emplearse archivos de sonido (por ejemplo
formatos `.wav` o `.au`) con información de 16 bits en estéreo a 44100
muestras/s, codificación PCM. Al quemar con `cdrecord` en lugar de la
opción `-data` debe emplearse `-audio`.

### Lecturas recomendadas y referencias Quemadoras {#referencias-quemadoras}

- Puede consultar más sobre creación de imágenes para CDs con
`man mkisofs` (tras haber instalado `cdrtools`)).

- Para conocer más sobre el quemado de CDs puede consultar `man cdrecord`
(también después de instalar el paquete `cdrtools`). En foros de
usuarios pueden verse mensajes como
<http://archives.neohapsis.com/archives/openbsd/2002-10/0548.html>,
<http://www.deadly.org/article.php3?sid=20031105030127&mode=flat> y
<http://archives.neohapsis.com/archives/openbsd/2001-12/2096.html>

[^que.1]: Si la sesión previa tenia -T esta también con mismo nombre de
    tablas (especificable con -table-name TN).


## Operaciones con DVD {#dvd}

El sistema de archivos de los DVD es UDF, que es diferente al de los CDs
(ISO9660). Desde la versión 4.0, OpenBSD soporta las versiones 1.02 y
1.50 de UDF en modos plain y VAT (ver <>

Las operaciones de montaje de DVDs, montaje de imagenes y copia de DVDs
a disco son como las de CDs remplazando el tipo `cd9660` por `udf` (ver
[xref](#montar-cd), [xref](#montar-imagen-iso) y
[xref](#crear-imagen-de-cd)).

Para quemar DVDs es necesario instalar el paquete `cdrtools`, el cual
incluye el programa `growisofs` que permite quemar DVDs al menos de dos
formas:

1.  Incluir una serie de archivos sin necesidad de preparar previamente
    una imagen del DVD. Por ejemplo para quemar un DVD que tenga los
    archivos `/home/copia/a` y `/home/copia/b`:

            doas growisofs -Z /dev/rcd0c -R /home/copia/a /home/copia/b
              

2.  Para quemar un DVD con la imagen ISO `dvd.iso`

            doas growisofs -dvd-compat -Z /dev/rcd0c=dvd.iso
                          

### Lecturas recomendadas y referencias DVD {#referencias-dvd}

- `man mount_udf` y `man growisofs`.

- Universal Disk Format:
<http://en.wikipedia.org/wiki/Universal_Disk_Format>


## Memoria USB

Para emplear una memoria USB después de conectarse debe:

1.  Examinar el dispositivo con el cual fue reconocida su memoria tras
    conectarla. Vea los últimos mensajes presentados por `dmesg`,
    típicamente será `sd0`.

2.  Examinar la partición por montar con

            doas disklabel /dev/rsd0c
                

    la partición que deberá montar podría ser `/dev/sd0c` o por ejemplo
    `/dev/sd0i`.

3.  Montar la partición apropiada en un punto del sistema de archivos,
    por ejemplo con:

            doas mkdir /mnt/usb
            doas mount /dev/sd0i /mnt/usb
                    

4.  Usar su memoria para leer/escribir (recordando que sólo podría
    escribir el usuario que sea dueño del punto de montaje)

5.  Cuando termine su utilización desmontar por ejemplo con:

            doas umount /mnt/usb
                

## Imagen cifrada

Es posible tener particiones cifradas, estas requieren que se ingrese
una clave antes de montarlas ---por ejemplo en el momento del arranque.

### Creación de la imagen {#crear-imagen}

Para crear una imagen de aprox. 500MB en el archivo `/var/post.img`
puede usar:


        doas dd if=/dev/zero of=/var/post.img bs=1024 count=500000
        doas vnconfig -ckv vnd0 /var/post.img
        doas newfs /dev/vnd0c
        doas vnconfig -u vnd0
              

La clave que ingrese tras `vnconfig -ckv vnd0 /var/post.img`, la
requerirá posteriormente para usar la imagen.

### Montar imagen

Esta imagen puede ser montadas (por ejemplo en `/var/postgresql`) con el
siguiente archivo de ordenes (ubíquelo por ejemplo en
`/usr/local/sbin/montapost.sh`):

    #!/bin/sh
    # Monta imagenes cifradas en OpenBSD. Dominio público. 2006.

    if (test ! -d /var/postgresql) then {
        mkdir /var/postgresql
        chown _postgresql:_postgresql /var/postgresql
    } fi;
    vnconfig -ckv vnd0 /var/post.img
    mount /dev/vnd0c /var/postgresql
        

y recuerde otorgar permiso de ejecución del mismo:

        doas chmod +x /usr/local/sbin/montapost.sh
        

Notará que este ejemplo es para montar una partición en la que
funcionará una base de datos PostgreSQL, si no existiera el usuario
`_postgresql` antes de ejecutar este archivo de ordenes ejecute
`chmod a+w /var/postgresql` y después de que haya instalado PostgreSQL:

        doas chown _postgresql:_postgresql /var/postgresql
        doas chmod o-w /var/postgresql
        

### Montar en el arranque {#montar-arranque}

Este script debe ejecutarse en el momento del arranque y antes de
iniciar la base de datos, agregue a su archivo `/etc/rc.local` (antes de
la inicialización de PostgreSQL):

        doas /usr/local/sbin/montapost.sh
            

De forma que en cada arranque el script le solicitará la clave antes de
continuar.

### Lecturas recomendadas y referencias Imagen Cifrada {#referencias-imagen-cifrada}

Página `man vnconfig`.

## Teclado en español {#teclado-en-espanol}

### En las consolas tipo texto {#consolas}

Si su teclado es español o latinoamericano puede configurarlo durante la
instalación. Después de instalado puede elegir otra configuración con
`keyb la` o `keyb es`

Si tiene un teclado US y desea emplear teclas muertas en la consola
puede usar desde la línea de ordenes:

        doas wsconsctl -w keyboard.map+="keycode 40=dead_acute dead_diaeresis"
        doas wsconsctl -w keyboard.map+="keycode 41=dead_grave dead_tilde"
        doas wsconsctl -w keyboard.map+="keycode 56=Cmd2 Multi_key" 

o para que esta configuración siempre sea realizada durante el arranque
agregue estas líneas al final de `/etc/rc.local` (puede agregar al final
de cada línea `> /dev/null`).

Estas líneas configuran entre otros:

'

:   como tecla muerta para la tilde (seguido de un espacio producirá el
    apostrofe)

"

:   como tecla muerta para la diéresis (seguido de un espacio producirá
    las comillas)

\`

:   como tecla muerta para el acento grave (seguido de un espacio
    produce el apostrofe izquierdo)

\~

:   como tecla muerta para la virgulilla (seguido de un espacio produce
    \~)

\^

:   como tecla muerta para el acento circunflejo

Shift+Alt izquierdo

:   Como tecla de composición

La tecla de composición[^tec.1] le permitirá generar un carácter empleando
una secuencia de dos teclas. Por ejemplo si presiona la tecla de
composición (i.e Shift+Alt izquierdo con la configuración presentada), y
después presiona ? seguido de ? obtendrá el carácter ¿. En el apendice
[Caracteres que pueden generarse](#caracteres-que-pueden-generarse)
encontrará una tabla con todas las combinaciones de teclas que pueden
usarse con la tecla compose y con teclas muertas.

### X-Window {#teclado-xwindow}

Dado que X-Window emplea el teclado en modo crudo la configuración que
haga para las consolas virtuales no quedará disponible.

Si tiene un teclado en español puede configurarlo con `xorgcfg` o bien
con `xorgcfg -textmode`, o bien editando el archivo `/etc/X11/xorg.conf`
para que en la sección del teclado quede la línea:

        Option  "XkbLayout" "es"
        

o si su teclado es latinoamericano remplace `es` por `latam`.

Si tiene un teclado en inglés puede agregar las siguientes líneas a su
archivo `~/.Xmodmap`

        keycode 64=Alt_L Multi_key
        keycode 48=dead_acute dead_diaeresis
        keycode 49=dead_grave dead_tilde 

y asegurarse de ejecutar `xmodmap ~/.Xmodmap` durante el arranque de su
sesión X (podría ser por ejemplo agregándolo a `~/.xsession`)

[^tec.1]: Tecla de composición: en inglés *compose key*
