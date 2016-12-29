Quemadora de CD-R y CD-RW {#quemadora}
-------------------------

Una quemadora de CD-R y CD-RW se puede comportar como un lector de CDs y
usarse como se explica en la sección sobre unidades de CD (ver
[???](#cd).

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
112120 puede crear la imagen (`/home/imagen/micd.iso`) empleando el
comando:

        doas dd if=/dev/rcd0c of=/home/imagen/micd.iso bs=2048 count=112120
          

### Crear una imagen nueva ISO 9660 {#crear-nueva-imagen-iso}

Para crear una imágen ISO a partir de datos que usted elija, deje los
archivos y directorios por incluir en un directorio (digamos
`/home/EUSUARIO/imagen`), el cual después puede especificarse a
`mkisofs` (programa que hace parte del paquete `cdrtools`). El formato
estándar para salvar información en CD-ROMs (ISO9660) sólo permite
nombres de archivos con 8 caracteres, extensiones de 3 y restricciones
en la codificación de caracteres, hay algunas extensiones que permiten
aumentar este margen, una de estas que es algo portable es Rock Ridge
(funciona al menos en sistemas Unix y en Windows).

Para crear una imagen ISO con nombre `/home/EUSUARIO/micd.iso` a partir
de la información disponible en `/home/EUSUARIO/imagen` puede ejecutar
como usuario `root`:

        cd /home/EUSUARIO/imagen
        doas mkisofs -r -l -f -o /home/EUSUARIO/micd.iso  .
        

Note que la imagen creada emplea la extensión Rock Ridge (opción `-r`),
permite nombres largos (opción `-l`) y maneja enlaces simbólicos (opción
`-f`).

Por otra parte en sistemas i386 o amd64 es posible arrancar un
computador desde un CD, configurando el arranque del computador desde el
BIOS para que sea por la unidad y cuando la imágen del CD se crea con la
extensión El Torito. La extensión El Torito permite incluir la imágen de
un floppy que se usa para arrancar.

Para crear una imágen ISO que use extensión Rock Ridge, con una tabla de
contenido de cada directorio (`TRANS.TBL`), que emplee la imágen de
disquete `floppy.img` para arrancar, con información de derechos de
reproducción del archivo `/home/EUSUARIO/Derechos.txt`, siguiendo
enlaces simbólicos y con la jerarquía de directorios y archivos de
`/home/EUSUARIO/imagen/` (en la que no debe existir el archivo
`boot.catalog`) use:

        cd /home/EUSUARIO/imagen
        doas mkisofs -b floppy.img -c boot.catalog -copyright /home/EUSUARIO/Derechos.txt \
          -r -l -f -o /home/EUSUARIO/micd.iso  .
        

### Quemado de una imagen ISO 9660 en un CD-R o en un CD-RW {#quemar-imagen-iso}

Para escribir una imágen ISO (`micd.iso`) con datos en un CD-R, puede
emplear el programa `cdrecord`, el cual puede emplear como dispositivo
uno de la forma `/dev/cd0c` o bien `/dev/rcd0c:0,0,0`, por ejemplo:

        doas cdrecord dev=/dev/cd0c -data speed=16 /home/EUSUARIO/micd.iso
        

Si emplea un CD-RW tenga en cuenta blanquearlo antes de escribir usando
la opción `blank=fast`:

        doas cdrecord dev=/dev/cd0c -data blank=fast speed=16 /home/EUSUARIO/micd.iso
        

Si desea emplear varias sesiones en un mismo CD-R (o CD-RW) tenga en
cuenta:

-   La primera sesión se hace creando una imágen ISO usual y al quemar
    con cdrecord agregue la opción `-multi`.

-   Las imágenes de sesiones posteriores deben crearse empleando la
    opción `-C` de `mkisofs` [^1]. Los datos precisos que debe pasar a
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

### Referencias {#referencias-quemadoras}

Puede consultar más sobre creación de imágenes para CDs con
`man mkisofs` (tras haber instalado `cdrtools`)).

Para conocer más sobre el quemado de CDs puede consultar `man cdrecord`
(también después de instalar el paquete `cdrtools`). En foros de
usuarios pueden verse mensajes como
[](http://archives.neohapsis.com/archives/openbsd/2002-10/0548.html
    ),
[](http://www.deadly.org/article.php3?sid=20031105030127&mode=flat) y
[](http://archives.neohapsis.com/archives/openbsd/2001-12/2096.html)

[^1]: Si la sesión previa tenia -T esta también con mismo nombre de
    tablas (especificable con -table-name TN).
