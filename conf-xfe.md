### `xfe`

La operación básica se describe en [???](#basico_adJ), aquí describimos
algunos detalles de configuración.

El archivo de configuración se ubica en `~/.config/xfe/xferc`. La
mayoría de posibilidades se configuran desde [Editar &gt;
Preferencias]{.menuchoice}, sin embargo para que opere bien
[Herramientas &gt; Ventana superusuario nueva]{.menuchoice} en adJ el
archivo de configuración en la sección `OPTIONS` debe incluir:

    uso_sudo=1
    sudo_nopasswd=1
            
