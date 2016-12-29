doas
----

Este programa permite ejecutar comandos privilegiados a algunos
usuarios. A partir de adJ y OpenBSD 5.8 el sistema base incluye `doas`
como remplazo del antiguo `sudo`. `doas` es más simple y fácil de
auditar.

Se configura en `/etc/doas.conf`. Un ejemplo mínimo es:

        permit nopass keepenv :wheel

que permitirá su uso sin requerir clave a todos los usuarios del grupo
`wheel` manteniendo las varibles de ambiente.

Una vez configurado, puede ejecutar un comando privilegiado desde una
cuenta configurada con `doas comando`. Por ejemplo:

        doas vi /etc/rc.conf.local 

### sudo

El programa `sudo` se mantiene como paquete, si lo requiere instalelo
con:

        pkg_add sudo

Se configura en `/etc/sudoers` que debe editarse con `visudo`.

Consulte los ejemplos allí presentados en líneas con comentarios y quite
el comentario a la configuración que considere apropiada. Por ejemplo si
desea que todo usuario que esté en el grupo `wheel` pueda emplear `sudo`
sin necesidad de ingresar una clave, quite el comentario a la línea:

        %wheel  ALL=(ALL)       NOPASSWD: ALL

Puede verse en <http://rr.sans.org/authentic/sudo.php> interacción entre
`sudo` y `ssh` para administrar una red.
