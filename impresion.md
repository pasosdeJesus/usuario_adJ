Impresión {#impresion}
---------

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
pendientes [^1], que es atendida automáticamente (i.e de ella se envían
trabajos pendientes cuando la impresora está disponible) por un
programa.

lpr
Nombre del programa empleado para poner una impresión más en su cola de
impresiones pendientes.

Cada impresora configurada tiene un nombre, la impresora por defecto se
llama `lp` [^2].

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

lpq
Nombre del programa empleado para examinar la cola de sus impresiones
pendientes.

lprm
Nombre del programa empleado para eliminar una impresión de la cola de
impresiones pendientes.

Para imprimir gráficas y documentos con diversos tipos de letra o
colores, primero debe convertirse la información a secuencias de control
particulares de su impresora. Cómo de una impresora a otra varían los
secuencias de control, en sistemas tipo Unix con LPD suele emplearse
PostScript (que es un lenguaje apropiado para documentos por imprimir)
como formato común y se usan los filtros del programa Ghostscript para
traducir de PostScript al formato particular de su impresora [^3]. Si se
usa CUPS es posible emplear controladores particulares para su impresora
y no depender de Ghostscript.

Ghostscript es un programa que puede leer documentos PostScript y PDF
[^4] y presentarlos en una ventana de X-Window o transformarlos al
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
[](http://www.ghostscript.com/pipermail/bug-gs/2001-August/000641.html),
resulta posible rotar una página, editando el archivo y en la sección
`%%%BeginPageSetup` agregando después de establecer tamaño de página,
e.g. `595 842 /a4 setpagesize`:

        currentpagedevice /PageSize get aload pop translate
        180 rotate
        

Tanto PostScript como PDF requieren bastante espacio para describir un
documento, usualmente los documentos PDF requieren menos porque
mantienen la información comprimida. Para convertir entre PostScript y
PDF se emplean `ps2pdf` y `pdf2ps` [^5]. Para visualizar e imprimir un
PDF, además de `gv`, puede emplear `xpdf` o el programa Acrobat Reader
(`acroread`).

xpdf
Programa empleado para consultar documentos PDF.

ps2pdf
Programa para transformar de PostScript a PDF.

pdf2ps
Programa para transformar de PDF a PostScript.

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
VER-OPENBSD. Una vez instalado puede ejecutarlo con

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
archivo de errores de `cups` en: `/usr/local/var/log/cups/error_log`.

#### Utilización de CUPS {#uso-cups}

El paquete de `cups` cuenta con programas análogos a los de LPD, pero
ubicados en `/usr/local/bin`. Diversos programas emplearan el comandos
`lpr` para hacer impresiones, así que tiene dos opciones:

-   Ejecutar `cups-enable` que remplazará los ejecutables relacionados
    con impresión de `/usr/` con los de CUPS disponibles en
    `/usr/local/`.

-   Configurar cada programa para que en lugar de emplear `/usr/bin/lpr`
    utilice `/usr/local/bin/lpr`. Por ejemplo así debe configurar xpdf.

### foomatic

`foomatic` ofrece gran cantidad de controladores para una variada gama
de impresoras, estos controladores e instrucciones para impresoras
particulares están disponibles en [](http://www.openprinting.org) Es
posible emplearlos bien con `lpr` o bien con `cups`.

#### Foomatic con LPR {#foomatic-lpr}

Si la impresora está impresora está conectada a `/dev/lpt0` basta que
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
                  

[^1]: En el caso de LPD el directorio con la cola de trabajos de una
    impresora se configura en `/etc/printcap`, en el caso de `lp` el
    directorio por defecto es `/var/spool/outputlpd/lp`.

[^2]: Normalmente puede configurar otro nombre para la impresora por
    defecto en la variable de ambiente PRINTER.

[^3]: Hay algunas impresoras que pueden imprimir PostScript
    directamente, pero en general para hacer la traducción de PostScript
    al lenguaje de una impresora se requiere un filtro que el
    administrador del sistema debe configurar.

[^4]: PDF (*Portable Document Format* es otro lenguaje para impresión,
    de documentos con gráficas y diversos tipos de letras, basado en
    PostScript (de la misma compañía ---Adobe).

[^5]: De acuerdo a Printig-HOWTO estas herramientas ofrecen la
    funcionalidad de las herramientas "*distiller*" de Adobe.
