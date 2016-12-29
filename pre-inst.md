Prerequisitos para la instalación {#prerequisitos-para-la-instalacion}
---------------------------------

1.  Un computador con procesador de 64 bits de la familia x86 (hay
    imagenes de versiones anteriores a la 4.9 para procesadores de 32
    bits).

2.  Componentes básicos para la instalación en un medio que pueda
    acceder. Es decir en uno de los siguientes:

    -   DVD: Puede descargarlo de
        [](ftp://ftp.pasosdeJesus.org/pub/AprendiendoDeJesus) por
        ejemplo con el programa `ftp` de OpenBSD:

                ftp -C ftp://ftp.pasosdeJesus.org/pub/AprendiendoDeJesus/AprendiendoDeJesusVER-ADJ-amd64.iso
                                  

        o bien con el programa `wget`:

                wget -c ftp://ftp.pasosdeJesus.org/pub/AprendiendoDeJesus/AprendiendoDeJesusVER-ADJ-amd64.iso 
                                  

        Usando estas formas podrá reanudar la transferencia en caso de
        que se interrumpa. Otra posibilidad que tiene que puede acelerar
        la descarga, pero sin posibilidad de reanudar en caso de que se
        interrumpa, es emplear el programa `rsync`:

                rsync -vz rsync://ftp.pasosdeJesus.org/AprendiendoDeJesus/AprendiendoDeJesusVER-ADJ-amd64.iso .  
                                  

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

    Aunque es posible realizar la descarga de imagenes ISO, recomendamos
    comprar[^1] los CDs oficiales de instalación para apoyar los
    proyectos OpenBSD y adJ. La estructura del CD oficial de OpenBSD
    tiene derechos de reproducción restrictivos ---sólo la estructura,
    las fuentes son de libre redistribución en su mayoría cubiertas por
    la licencia BSD. Por esto en caso de comprar CDs oficiales comprelos
    sólo a los desarrolladores o a redistribuidores autorizados. En el
    caso de OpenBSD ver [](http://www.openbsd.org/orders.html) y en el
    caso de adJ ver [](https://aprendiendo.pasosdeJesus.org).

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
    bien soportado, o tener un sistema dual (ver [???](#duales)).

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
    [](http://aprendiendo.pasosdejesus.org/?id=AdJ+&VER-ADJ;+-+Aprendiendo+de+Jesus+&VER-ADJ;)

[^1]: Los CDs de OpenBSD ordenados por la página web de OpenBSD si
    llegan a Colombia.
