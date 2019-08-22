# Interprete de ordenes {#interprete_de_ordenes}

## Archivos y permisos {#archivos_y_permisos}

En esta sección se introducen diveras ordenes para administrar
archivos y permisos desde un interprete de ordenes.

Una orden usualmente recibe opciones y parametros que especifican que
operación realizar; algunos parametros son indispensables mientras que
las opciones modifican el comportamiento por defecto de una orden (y
por tanto son opcionales). En la ayuda presentada por la orden `man` y
en estas guías emplemos como notación los paréntesis cuadrados `[ ]`
para encerrar parametros opcionales y opciones. Por ejemplo

     ls [-l] [ruta] 

indica que la orden `ls` puede recibir la opción `-l` y una ruta como
parámetro (las opciones suelen comenzar con uno o dos guiones). Puede
descubrir que hace tal opción y el parámetro tecleando `ls /
      -l` y comparando con `ls -l`, `ls /`, y `ls`.

[//]: # "opciones"
[//]: # "Alteran el comportamiento por defecto de una orden, suelen comenzar con uno o dos guiones."

### Administración de archivos, directorios y enlaces {#administracion-de-archivos-directorios-y-enlaces}

El programa `ls` por defecto presenta los nombres de archivos que no
comienzan con el caracter '.' y que están en el directorio de trabajo
del usuaurio. Los archivos cuyos nombres comienzan con el caracter punto
suelen llamarse archivos de configuración, si desea verlos también al
usar la orden `ls`, puede emplear la opción `-a` (i.e. teclear
`ls -a`). Si desea ver los archivos de un directorio diferente puede dar
como argumento el nombre del directorio, por ejemplo `ls
      /usr/bin`. Además de `-a` y `-l`, la orden `ls` tiene muchas
otras opciones que le permiten especificar que mostrar y como mostrarlo.

![Sesión en la que se examinan archivoos y permisos](perm.eps)

A continuación se presentan algunos programas para administrar archivos,
junto con una breve descripción y unas pocas opciones ---Puede consultar
todas las opciones que recibe un programa con `man`:

[//]: # "ln"
[//]: # "Orden para crear nuevos enlaces a un archivo o enlaces simbólicos al
nombre de un archivo."

[//]: # "mkdir"
[//]: # "Orden para crear un directorio."

[//]: # "mv"
[//]: # "Orden para mover o renombrar un archivo o directorio."

[//]: # "rm"
[//]: # "Orden para borrar archivos o directorios."

[//]: # "cp"
[//]: # "Orden para copiar archivos."

[//]: # "df"
[//]: # "Orden para examinar el espacio disponible en los dispositivos de almacenamiento."

[//]: # "du"
[//]: # "Orden para examinar el espacio usado por un directorio."

`ln` `[-s]` fuente destino

:   Crea un nuevo enlace para el archivo referenciado por fuente pero
    con el nombre destino. Por ejemplo si en el directorio de trabajo
    hay un archivo enlazado con el nombre `carta.txt` puede crearse otro
    enlace llamado `diario.txt` con:

        ln carta.txt diario.txt

    Después de hacerlo tanto `carta.txt` como `diario.txt` serán nombres
    que enlazarán la misma información. La opción `-s` indica que el
    enlace debe ser símbolico, lo cual en general es más flexible que la
    opción por defecto [^1].

`mkdir` `[-p]` ruta

:   Crea un directorio con la ruta especificada. Sin la opción `-p`
    todos los directorios de la ruta excepto el último deben existir (el
    último es el nuevo directorio por crear). Con la opción `-p` el
    orden `mkdir` creará todos los directorios necesarios para
    construir la ruta.

`mv` fuente destino

:   Renombra o mueve el archivo fuente en la localización/nombre
    destino.

`rm` `[-i]` `[-rf]` archivo

:   Borra un archivo.

    > **Warning**
    >
    > Una vez se borra un archivo no hay un método sencillo para
    > recuperarlo.

    La opción `-i` confirma antes de borrar cada archivo, las opciones
    `-rf` permiten borrar directorios enteros junto con todos los
    subdirectorios que contengan (la opción `-r` por si sóla borra en
    subdirectorios, la opción `-f` borra sin preguntar al usuario y sin
    producir fallas cuando no haya archivos por borrar).

`cp` `[-rf]` fuente destino

:   Copia del archivo fuente al destino especificado. Si se usa la
    opción `-rf` también se copiaran subdirectorios.

`df` `[-h]`

:   Para examinar espacio disponible en los dispositivos de
    almacenamiento, en particular el de las particiones cuyos sistemas
    de archivos estén montados (ver [Montaje y desmontaje de sistemas de
    archivos](#montaje-y-desmontaje-de-sistemas-de-archivos)). Puede
    emplearse con la opción `-h` para obtener datos en unidades más
    conocidas (en Kilobytes, Megabytes y Gigabytes) [^2].

`du` `[-s]` `[ruta
       [ruta] ... ]`

:   Para examinar espacio empleado por cada una de las ruta y sus
    archivos y subdirectorios. Si no se especifica ruta alguna, este
    orden da información sobre el directorio de trabajo. La opción
    `-s` presnta totales de cada ruta (sin incluir los detalles de cada
    archivo o subdirectorio).

Al usar la opción `-a` con `ls`, por lo menos verá dos directorios más:
`.` y `..`, el primero denota el directorio que examinó y el segundo
denota el directorio en el cual está el directorio examinado. Por
ejemplo si su directorio de trabajo es `/home/pepe` el caracter `.`
abrevia `/home/pepe` mientras que `..` abrevia `/home`.

En la mayoría de programas y en el intérprete de ordenes podrá emplear
tanto `.` como `..` para referenciar archivos y subdirectorios relativos
al directorio de trabajo. Así mismo los archivos y directorios que esten
en su directorio de trabajo puede referenciarlo sin prefijo alguno, por
ejemplo `du` es equivalente a `du` porque muestra la utilización de disco
del directorio de trabajo. Si en su directorio de trabajo tiene un
directorio notas que tiene un archivo `2000.txt` puede verlo con el
orden `less notas/2000.txt`.

También podrá emplear `~` que abrevia su directorio personal (i.e
`/home/sulogin`). Por ejemplo si desde un intérprete de ordenes teclea
`cd ~`, después `cd ../..` y después `pwd` verá que estará ubicado en el
directorio raíz.

Otra facilidad que brinda el interprete de ordenes es la expansión de
nombres de archivos con los comodines \* y ?. ? indica una letra
mientras que \* indica una cantidad cualquiera de letras. Por ejemplo
`ls /var/lo?` lista todos los archivos del directorio `var` de tres
letras que comiencen con `lo`, mientras que `cp *gz ~` copia todos 
los archivos con sufijo gz en el directorio personal del usuario.

[//]: # "comodín"
[//]: # "? y \* son ejemplos de caracteres ..."

### Permisos

Para brindar algo de privacidad y protección cada archivo o directorio
tiene asociados permisos diferentes para el dueño, para el grupo y para
los demás usuarios. En el caso de archivos los permisos que pueden darse
o quitarse son: (r) lectura, (w) escritura y (x) ejecución. En el caso
de directorios los permisos son: (r) para listar los archivos, (w) para
escribir, crear o borrar archivos y (x) para acceder a archivos del
directorio. [^3].

Desde un administrador de archivos, puede ver los permisos de un archivo
con el botón derecho del mouse cuando el puntero está sobre el archivo,
escogiendo la opción apropiada del menú que aparece. Desde un interprete
de ordenes puede emplear la orden `ls` con la opción `-l`. Un ejemplo
del resultado de este orden se presenta a continuación:

    drwxr-xr-x    5 pepe   users        4096 Feb 21 06:31 graficas
    -rw-r-----    1 pepe   users       62561 May 13 18:13 c.tar.gz
    lrwxrwxrwx    1 pepe   users          12 Nov 12  2000 a -> /etc/hosts

La primera línea presenta un directorio (la `d` al principio de la línea
lo indica), la segunda presenta un archivo (el guión inicial lo indica)
y la tercera un enlace. El nombre del directorio es `graficas` tiene 5
archivos, fue modificado por última vez el 21 de Febrero del año en
curso a las 6:31AM, el dueño es `pepe`, el grupo es `users` y el tamaño
es 4096 bytes ---en realidad el tamaño cobra sentido sólo en el caso de
archivos como `c.tar.gz` cuyo tamaño es 62561 bytes. Los tres caracteres
`rwx` que siguen a la `d` inicial indican los permisos para el dueño,
los tres siguientes `r-x` indican los permisos para el grupo y los tres
siguientes `r-x` indican los permisos para el resto de usuarios. Como el
orden de estos permisos es siempre el mismo (primero lectura `r`,
después escritura `w` y después ejecución `x`), resulta que el archivo
`x.tar.gz` no es ejecutable, que puede ser leido por el dueño y el grupo
pero no por los demás usuarios, además puede ser escrito sólo por
`pepe`. Del enlace podemos destacar que se llama `a`, que enlaza al
archivo `/usr/bin/awk` y que su tamaño y permisos reales los heredará de
`/usr/bin/awk`.

Los permisos de un archivo pueden ser modificados por el dueño o por el
administrador del sistema con la orden `chmod` que espera dos
parámetros: cambio por realizar al permiso y nombre del archivo por
cambiar. Los permisos se pueden especificar en octal o con una o más
letras para identificar al usuario (u para el usuario, g para el grupo,
o para los demás usuarios y a para todos), un +, un - o un = y después
letras para identificar los permisos (r, w o x). Por ejemplo

`chmod og+x sube.sh`

:   Da a los demás usuarios y al grupo permiso de ejecución del archivo
    `sube.sh` ---que debe estar en el directorio desde el cual se da el
    orden.

`chmod a-w deu.txt`

:   Quita el permiso de escritura en el archivo `deu.txt` tanto al
    dueño, como al grupo, como a los demás usuarios. Este mismo
    resultado puede obtenerse con la orden `chmod -w deu.txt`. Cuando
    no se especifican usuarios `chmod` toma por defecto todos los
    usuarios.

`chmod u=rxw,g=rx,o= textos`

:   Cambia permisos del archivo (o directorio) textos, el usuario puede
    leer, ejecutar y escribir, el grupo puede leer y ejecutar mientras
    que los demás usuarios no tienen permisos.

[//]: # "chmod"
[//]: # "Orden para cambiar los permisos de sus archivos."

El dueño de un archivo pueden ser modificados sólo por el administrador
del sistema con el programa `chown`. Un usuario que pertenezca a varios
grupos puede cambiar el grupo de uno de sus archivos a alguno de los
grupos a los que perteneza con el program `chgrp`, por ejemplo

    chgrp estudiantes tarea1.txt

Cambiará el grupo del archivo `tarea1.txt` a `estudiantes`. Los grupos a
los cuales un usuario pertenece son mostrados por el programa `groups`.

### Lecturas recomendadas: Archivos y permisos

-   En estas guías puede consultar más sobre permisos y administración,
    ver [Administración de usuarios](#administracion-de-usuarios).

-   Cada uno de los ordenes para administrar archivos es muy flexible y
    configurable por medio de opciones, recomendamos de forma especial
    consultar las páginas `man` de cada uno de ellos.

-   La jerarquía de directorios, los archivos y los permisos se
    organizan en las particiones de un disco duro o en un disquette
    empleando un sistema de archivo. Puede conocer algo más sobre el
    tema en la guía [Administración de
    archivos](#administracion-de-archivos) o con `man fs`.

-   Como complemento a esta lectura, puede consultar varias secciones de
    la documentación de fileutils con `info
        fileutils` o en línea en
    [](http://www.gnu.org/manual/fileutils/html_mono/fileutils.html).

### Ejercicios: Archivos y permisos

1. ¿En su directorio personal hay archivos de configuración? En caso
afirmativo cite algunos.

[//]: # "**R:** `~/.bashrc`"

2. Estando en un intérprete de ordenes vaya al directorio
`/usr/share/pixmaps` y liste con `ls` y caracteres comodín todos los
archivos con extensión `.xpm`. Desde bash, copie uno de esos archivos a
su directorio con la orden `cp`. (Ayuda: busque ayuda sobre la orden
`cp` y emplee `~` para referirse a su directorio).

[//]: # "**R:**   cd /usr/share/pixmaps
    ls *.xmp
    cp arc.xmp ~ "

3. Para mejorar la seguridad de sus archivos y evitar que otras
personas puedan consultarlos, quite a su directorio el permiso de
ejecución para el grupo y para otros usuarios.

[//]: # "**R:** cd \~ ; chmod og-x ."

4. Revise los directorios de los usuarios del sistema en `/home`.
Identifique y liste directorios con permisos de seguridad deficientes.
Intente cambiar los permisos de archivos o directorios de otro usuario.

[//]: # "**R:** cd /home ; ls -l ; chmod -w pepe"


