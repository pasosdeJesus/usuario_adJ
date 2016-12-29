Inicio del sistema
------------------

El arranque se realiza de acuerdo al archivo `/etc/rc` (que no debe
modificarse), este archivo en particular lee variables definidas por el
usuario en `/etc/rc.conf.local` donde puede especificar que servicios
desea iniciar durante el arranque. Un servicio es un programa que se
mantiene en operación mientras el computador está encendido, esperando
conexiones o requerimientos de programas o de otros servicios para
atenderlos, por ejemplo un servidor web es un servicio (que responde a
requerimientos de páginas web en cualquier momento que un usuario las
realice). `/etc/rc` también iniciará los servicios típicos del sistema y
algunos proveidos por paquetes y después ejecutará `/etc/rc.local`.

En el archivo `/etc/rc.conf.local` pueden definirse variables asociadas
a servicios (puede verse el listado de variables posibles para el
sistema base en `/etc/rc.conf`), si el valor de una variable es `NO` el
servicio relacionado no se activa, mientras que otro valor activa el
servicio y es pasado como parámetro (si no se desean parámetros
adicionales puede simplemente asignarse ""). Por ejemplo para iniciar
XDM en cada arranque:

        xdm_flags=""
        

Los servicios proveidos por paquetes que son iniciados se especifican en
la variable `pkg_scripts`, que se define en el archivo
`/etc/rc.conf.local`. Los servicios tanto del sistema base como de
paquetes típicamente tiene un archivo en el directorio `/etc/rc.d`.
Estos archivos de comandos pueden ejecutarse con una de las siguientes
opciones:

`start`

:   Para iniciar el servicio.

`stop`

:   Para detener el servicio.

`check`

:   Para examinar el estado del servicio. Si retorna 0 significa que el
    servicio está operando, 1 de lo contrario.

`restart`

:   Detiene y vuelve a iniciar el servicio.

`reload`

:   Si el servicio está operando lo vuelve a iniciar.

En adJ el archivo de comandos `/etc/rc.local` además de poder contener
acciones por realizar en el arranque, permite reiniciar servicios que se
hayan detenido. Por esto tras detener un servicio (bien intencionalmente
o por error) puede ejecutar este archivo de comandos para reiniciarlo
con:

        doas sh /etc/rc.local
              
