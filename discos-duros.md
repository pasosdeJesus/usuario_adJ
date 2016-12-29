Discos duros
------------

### Particiones {#particiones-slices}

Hay dos niveles de particiones: (1) del BIOS y (2) particulares de
OpenBSD. Las primeras se configuran con `fdisk` y las segundas se crean
dentro de las primeras con `disklabel`.

### Sistema de archivos ffs

Un sistema de archivos ffs sólo puede crearse en una partición
identificada con `disklabel`. Como se explica en FFS, consta de:

-   Un superbloque con los parámetros básicos del sistema de archivos
    (e.g tamaño de cada bloque, lista de grupos de cilindros) y con los
    parámetros del hardware que afectan el desempeño[^1] (tipo de
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

> **Warning**
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

            sudo disklabel -E /dev/wd1c 

    en este modo puede examinar las particiones y divisiones del disco
    con p, puede ver una ayuda abreviada con h. Con m le será posible
    cambiar el tipo de una partición (por ejemplo puede ser `4.2BSD` si
    se trata de un sistema ffs o `swap` si se trata de un dispositivo
    para intercambio), y la ubicación.

    > **Caution**
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

            sudo swapon -a 

    o con:

            sudo swapctl -A -t blk 

    Ambos comandos intentarán montar como zonas de intercambio todos
    dispositivos por bloques de `/etc/fstab` que tengan la opción `sw`.
    Puede verificar la adición listando todas las zonas de intercambio
    con:

            sudo swapctl -l 

[^1]: Los parámetros del hardware mantenidos ayudan a localizar bloques
    libres de forma óptima.
