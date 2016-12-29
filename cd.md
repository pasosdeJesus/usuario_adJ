Unidad de CD-ROM {#cd}
----------------

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

        vnconfig -c svnd0 /home/EUSUARIO/micd.iso 
        mount /dev/svnd0a /mnt/tmp
        

### Referencias {#referencias-cd-y-quemadoras}

Más sobre montaje de archivos con `man fstab`.
