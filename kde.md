KDE
---

Para que funcione KDE primero debe instalar el paquete `kdebase`.
Eventualmente también estará interesad@ en instalar

-   `kde-i18n-es` que es localización en español

-   `kdeutils` que son diversas utilidades para KDE

Una vez instalado, la configuración de KDE depende del administrador de
vistas que emplee. El administrador de vistas por defecto es `xdm` (ver
[???](#configuracion-de-xorg)), pero si lo desea puede remplazarlo por
`kdm` como se explica más adelante.

Si desea usar `xdm` o no está usando un administrador de vistas, puede
configurar una cuenta para que use KDE creando o modificando el archivo
`~/.xsession` para que ejecute `startkde`. Por ejemplo si tal archivo no
existe en la cuenta de un usuario puede crearlo con:

        echo "PATH=$PATH:/usr/local/bin" > ~/.xsession
        echo "/usr/local/bin/startkde" >> ~/.xsession
        chmod +x ~/.xsession
              

Si desea emplear `kdm` como administrador de vistas en lugar de `xdm` ,
ejecute:

        /usr/local/bin/genkdmconf
              

asegurese de no iniciar `xdm`, por ejemplo poniendo en
`/etc/rc.conf.local`

        xdm_flags="NO"
              

y asegurese de iniciar `kdm` en cada arranque, por ejemplo agregando a
`/etc/rc.local`:

        if [ X"$kdm_flags" != X"NO" -a \
            -x /usr/local/bin/kdm ]; then
            /usr/local/bin/kdm  $kdm_flags
        fi
            

y en `/etc/rc.conf.local`:

        kdm_flags=""
            
