### FluxBox

La operación básica de este liviano y estético administrador de ventanas
se describe en [???](#basico_adJ), aquí describimos algunos detalles de
configuración.

Para emplearlo como administrador de ventanas por defecto debe
modificarse `~/.xsession`, así como en `~/.xinitrc` y agregar al final:

        if (test -x /usr/local/bin/startfluxbox) then {
            /usr/local/bin/startfluxbox
        } fi; 

Una vez en operación podrá realizar diversas configuraciones oprimiendo
el botón derecho sobre el escritorio en el menú `fluxbox menu`. Por
ejemplo podrá cambiar estilos en `System Styles` y esconder/mostrar la
barra de herramientas con `Configure -> Toolbar -> Visible` FluxBox
ejecutando `xfig`

Entre sus características:

-   Es altamente configurable (recursos, menús, decoración de ventanas y
    estilos).

-   Es muy liviano, requiere alrededor de 4MB en RAM.

-   Con Alt+\[Boton izquierdo\] permite cambiar ubicación de la ventana
    sobre la que está el curso, y con Alt+\[Botono derecho\] el tamaño.

El menú que presenta se configura en un archivo texto con una sintaxis
sencilla, puede cambiarse editando en `~/.fluxbox/menu`.

Los programas que se inician con el escritorio pueden configurarse en
`~/.fluxbox/startup`. Por ejemplo en este archivo puede configurar el
locale que usará agregando o cambiando la línea:

    export LANG=es_CO.UTF-8
        

La apariencia en general puede configurarse en `~/.fluxbox/init`

Puede configurar teclas rápidas en el archivo `~/.fluxbox/keys`

#### Lecturas recomendadas {#lecturas-conf-fluxbox}

-   Sitio oficial [](fluxbox.org).

-   Página sobre fluxbox de NetBSD [](http://wiki.netbsd.org/fluxbox/)

-   Página sobre fluxbox de Gentoo
    [](http://www.gentoo.org/doc/es/fluxbox-config.xml)


