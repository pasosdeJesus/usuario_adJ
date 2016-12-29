Disquetes e imágenes de disquetes {#disquetes-e-imagenes-de-disquetes}
---------------------------------

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
`sudo` (ver [sudo](#sudo)):

        doas mcopy *tgz a: 

o incluso con `sudo` y un alias hacer transparente la restricción para
los usuarios que puedan emplear `sudo`:

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
[???](#cd).
