ftp
---

Además de las características usuales de un cliente `ftp` (RFC 959,
extendido en RFC 1123), el cliente `ftp` de OpenBSD:

-   Realiza conexiones pasivas por defecto. Sin embargo algunos
    servidores de ftp requiere conexiones activas, si ese es el caso
    (por ejemplo cuando el servidor responde a `ls` con
    `425 Can't open data connection`) emplee la opción `-A`.

-   Emplea el archivo de configuración `~/.netrc` para establecer
    conexiones automáticamente. En ese archivo usted puede especificar
    servidores a los que suele conectarse (y por ejemplo emplear
    redireccionamiento para automatizar operaciones . Este archivo puede
    tener comentarios (líneas iniciadas con el caracter '\#') o líneas
    como:

            machine ESERV login EUSUARIO
            machine rt.fm login anonymous passwd EUSUARIO@EDOMINIO
                

    que indican emplear el usuario EUSUARIO al conectarse a ESERV
    (pedirá la clave al hacer la conexión) y emplear el usuario
    `anonymous`, con clave `EUSUARIO@EDOMINIO` al hacer conexiones con
    `rt.fm`.

    > **Warning**
    >
    > Las claves que se almacenan en este archivo son textos planos que
    > el superusuario del sistema podría ver. Para que otros usuarios no
    > puedan verlas quite el permiso de lectura para otros usuarios y
    > para el grupo:
    >
    >         chmod og-r ~/.netrc
    >               
    >
    > .

-   Permite especificar el URL (iniciado con `http://` o `ftp://`) de un
    archivo por descargar en la línea de comandos (y realiza
    autenticación automática si es ftp:// y se ha configurado
    `~/.netrc`, o si el URL es análogo a
    `ftp://EUSUARIO:miclave@ESERV/pub/doc.txt`). En este caso si se
    requiere puede emplearse la opción `-o` seguida del nombre del
    archivo con el que se desea salvar el archivo transmitido. También
    puede emplearse `*` para indicar transmisión de varios archivos.


