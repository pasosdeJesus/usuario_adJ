Imagen encriptada
-----------------

Es posible tener particiones encriptadas, estas requieren que se ingrese
una clave antes de montarlas ---por ejemplo en el momento del arranque.

### Creación de la imagen {#crear-imagen}

Para crear una imagen de aprox. 500MB en el archivo `/var/post.img`
puede usar:


        doas dd if=/dev/zero of=/var/post.img bs=1024 count=500000
        doas vnconfig -ckv svnd0 /var/post.img
        doas newfs /dev/svnd0c
        doas vnconfig -u svnd0
              

La clave que ingrese tras `vnconfig -ckv svnd0 /var/post.img`, la
requerirá posteriormente para usar la imagen.

### Montar imagen

Esta imagen puede ser montadas (por ejemplo en `/var/postgresql`) con el
siguiente archivo de comandos (ubíquelo por ejemplo en
`/usr/local/sbin/montapost.sh`):

    #!/bin/sh
    # Monta imagenes encriptadas en OpenBSD. Dominio público. 2006.

    if (test ! -d /var/postgresql) then {
        mkdir /var/postgresql
        chown _postgresql:_postgresql /var/postgresql
    } fi;
    vnconfig -ckv svnd0 /var/post.img
    mount /dev/svnd0c /var/postgresql
        

y recuerde otorgar permiso de ejecución del mismo:

        sudo chmod +x /usr/local/sbin/montapost.sh
        

Notará que este ejemplo es para montar una partición en la que
funcionará una base de datos PostgreSQL, si no existiera el usuario
`_postgresql` antes de ejecutar este archivo de comandos ejecute
`chmod a+w /var/postgresql` y después de que haya instalado PostgreSQL:

        sudo chown _postgresql:_postgresql /var/postgresql
        sudo chmod o-w /var/postgresql
        

### Montar en el arranque {#montar-arranque}

Este script debe ejecutarse en el momento del arranque y antes de
iniciar la base de datos, agregue a su archivo `/etc/rc.local` (antes de
la inicialización de PostgreSQL):

        sudo /usr/local/sbin/montapost.sh
            

De forma que en cada arranque el script le solicitará la clave antes de
continuar.

### Referencias {#referencias-imagen-encriptada}

Página `man vnconfig`.
