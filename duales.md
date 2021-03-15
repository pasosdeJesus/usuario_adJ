# Instalaciones duales {#duales}

Aunque no es recomendable, es posible tener en un mismo computador
OpenBSD/adJ y otros sistemas operativos. En esta sección se describen
algunos detalles de estas configuraciones.

## Dual con Linux {#con-linux}

### Arranque múltiple {#arranque-multiple}

Si deja en su computador tanto Linux como adJ podrá configurar 
GRUB para arrancar cualquiera de los dos sistemas.  Las instrucciones
precisas dependen de la versión de Ubuntu y la forma como haya 
instalado los sistemas, se sugiere leer 
<https://dhobsd.defensor.info/grub2.html>. 

Por ejemplo con Ubuntu 20.04, y suponiendo que el particionado es 
en modo EFI, debe agregar en `/etc/grub.d/40_custom`:

        menuentry "adJ" {
          set root=(hd0,gpt1)
            chainloader /efi/Boot/bootx64.efi
        } 
               

remplazando `gpt1` por la partición donde haya quedado el arranque EFI. 
Después ejecute:

        sudo update-grub2

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
menu de arranque que NTLDR puede presentar, descárguelo bien del CD adJ
del subdirectorio `util/bootpart` o de
<http://www.winimage.com/bootpart.htm>, descomprímalo y copie
`bootpart.exe` al directorio `C:\`. Inicie un interprete de ordenes
(Inicio-&gt;Ejecutar-&gt;cmd) y después:

        cd \
        bootpart 
                 

Con esto podrá ver el número de la partición de OpenBSD que distinguirá
porque su tipo es `a6`. Suponiendo que fuera la partición 1, después
desde el mismo interprete teclee:

        bootpart 1 lba openbsd.prt OpenBSD
                 

tras esto reinicie Windows y al arranque debe poder ver un menú que le
permite elegir con las flechas bien Windows XP o bien OpenBSD.

### Montaje de particiones NTFS {#discos-ntfs}

Es posible montar particiones escritas por Windows en formato
NTFS, pero sólo en modo lectura.

Puede montar una partición (digamos `wd0i`) con:

        mkdir /mnt/winc
        mount_ntfs /dev/wd0i /mnt/winc

o agregar una entrada en `/etc/fstab` para montaje automático en cada
arranque:

        /dev/wd0i /mnt/winc ntfs ro 0,0

