# Instalaciones duales {#duales}

Aunque no es recomendable, es posible tener en un mismo computador
OpenBSD y otros sistemas operativos. En esta sección se describen
algunos detalles de estas configuraciones.

## Dual con Linux {#con-linux}

### Arranque múltiple {#arranque-multiple}

Si deja en su computador tanto Linux como OpenBSD podrá configurar LILO
o GRUB para arrancar cualquiera de los dos sistemas. En caso de usar
LILO, desde Linux edite `/etc/lilo.conf` para dejar una entrada que
identifique su sistema Linux y otra para openBSD. En el siguiente
ejemplo Linux está en `/dev/hda2` mientras que OpenBSD en `/dev/hda1`:

    #Instalar LILO en MBR
    boot=/dev/hda

    # Linux, note que supone que el directorio raíz está en la segunda
    # partición primaria del primer disco IDE (/dev/hda2)
    image=/vmlinuz
        root=/dev/hda2
        label=Linux
        read-only

    # OpenBSD, note que supone que está en la primera partición primaria 
    # del primer disco IDE (/dev/hda1)
    other=/dev/hda1
        label=OpenBSD
        table=/dev/hda 

Una vez efectúe el cambio recuerde ejecutar:

        lilo

En caso de usar GRUB las instrucciones dependen de la versión que
emplee, puede ver opciones para diversas versiones en
[](http://dhobsd.pasosdejesus.org/index.php?id=Grub2). Por ejemplo con
Grub2-1.99 (incluido en Ubuntu 12.04), debe agregar en
`/etc/grub.d/40_custom`:

        menuentry "adJ" {
          set root=(hd0,msdos3)
          kopenbsd /bsd
        }
               

remplazando msdos3 por la partición primaria donde instaló. Después
ejecute:

        doas update-grub2

y reinicie.

### Montar directorios del otro sistema {#montaje-de-directorios-del-otro-sistema}

Desde OpenBSD podrá montar una partición ext2 de Linux (digamos
`/dev/wd0i` que puede examinar con `disklabel`) con:

        doas mkdir -p /mnt/linux
        doas mount -t ext2 /dev/wd0i /mnt/linux 

Desde Linux podrá montar una partición de OpenBSD usando el tipo ufs con
la opción 44bsd. Si una partición para OpenBSD está dividida en slices
Linux los detectará durante el arranque y asignará dispositivos
apropiados (busque los nombres entre los mensajes de `dmesg`):

        sudo mkdir -p /mnt/openbsd
        sudo mount -t ufs -o ufstype=44bsd /dev/hda1 /mnt/openbsd 

## Dual con Windows XP o NT {#con-windows-xp}

### Arranque múltiple {#arranque-multiple-ntfs}

El arranque múltiple puede administrarse con NTLDR el gestor de arranque
de Windows XP/NT. La herramienta Bootpart le facilitará configurar el
menu de arranque que NTLDR puede presentar, descarguelo bien del CD adJ
del subdirectorio `util/bootpart` o de
[](http://www.winimage.com/bootpart.htm), descomprimalo y copie
`bootpart.exe` al directorio `C:\`. Inice un interprete de comandos
(Inicio-&gt;Ejecutar-&gt;cmd) y después:

        cd \
        bootpart 
                 

Con esto podrá ver el número de la partición de OpenBSD que distinguirá
porque su tipo es `a6`. Suponiendo que fuera la partición 1, después
desde el mismo interprete teclee:

        bootpart 1 lba openbsd.prt OpenBSD
                 

tras esto reinicie Windows y al arranque debe poder ver un menú que le
permite elegir con las flechas bien Windows XP o bien OpenBSD.

### Montaje de particiones NTFS {#discos-xp}

Es posible montar particiones escritas por Windows NT o XP en formato
NTFS, pero sólo en modo lectura.

Puede montar una partición (digamos `wd0i`) con:

        mkdir /mnt/winc
        mount_ntfs /dev/wd0i /mnt/winc

o agregar una entrada en `/etc/fstab` para montaje automático en cada
arranque:

        /dev/wd0i /mnt/winc ntfs ro 0,0

