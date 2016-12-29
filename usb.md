Memoria USB
-----------

Para emplear una memoria USB después de conectarse debe:

1.  Examinar el dispositivo con el cual fue reconocida su memoria tras
    conectarla. Vea los últimos mensajes presentados por `dmesg`,
    típicamente será `sd0`.

2.  Examinar la partición por montar con

            doas disklabel /dev/rsd0c
                

    la partición que deberá montar podría ser `/dev/sd0c` o por ejemplo
    `/dev/sd0i`.

3.  Montar la partición apropiada en un punto del sistema de archivos,
    por ejemplo con:

            doas mkdir /mnt/usb
            doas mount /dev/sd0i /mnt/usb
                    

4.  Usar su memoria para leer/escribir (recordando que sólo podría
    escribir el usuario que sea dueño del punto de montaje)

5.  Cuando termine su utilización desmontar por ejemplo con:

            doas umount /mnt/usb
                


