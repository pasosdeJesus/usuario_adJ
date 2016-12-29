### `mutt`

El uso básico de mutt puede consultarlo en [???](#basico_adJ).

#### Enviado correo con `sendmail` de otro computador {#otro-smtp}

Para enviar correos `mutt` corre por defecto el programa `sendmail` (por
defecto con parámetros: `sendmail -oem -oi`), si usted prefiere o
necesita emplear el `sendmail` de otro computador puede:

-   Hacer un script (digamos `/home/EUSUARIO/scripts/envia.sh`) que
    llame al `sendmail` remoto (por ejemplo con `ssh`) y le pase lo que
    recibe por entrada estándar:

        #!/bin/sh
        # envia.sh Dominio público

        if (test "$SSH_AUTH_SOCK" = "") then {
            echo "Usar con ssh-agent";
            exit 2;
        } fi;

        cat - | ssh EUSUARIO@ECLIENTE /usr/sbin/sendmail -oem -oi

    Note que este script está hecho para ser ejecutado junto con el
    agente de autenticación de ssh (i.e `ssh-agent`).

-   Configure `mutt` para que emplee su script con la variable
    `sendmail`, la cual puede establecer en su archivo `~/.muttrc` con
    algo como:

            set sendmail=/home/EUSUARIO/scripts/envia.sh

-   Asegurese de ejecutar `mutt` junto con el agente de autenticación de
    `ssh`. Por ejemplo con:

            ssh-agent /bin/ksh
            ssh-add
            mutt
                            

    o si emplea XWindow es posible que pueda configurar su manejador de
    escritorio o su administrador de ventanas para que toda la sesión
    emplee el agente (ver un ejemplo en [???](#fluxbox)).

#### Lecturas recomendadas {#lecturas-mutt}

-   Página man de `mutt`

-   Sección sobre `mutt` de basico\_adJ.


