Teclado en español {#teclado-en-espanol}
------------------

### En las consolas tipo texto {#consolas}

Si su teclado es español o latinoamericano puede configurarlo durante la
instalación. Después de instalado puede elegir otra configuración con
`keyb la` o `keyb es`

Si tiene un teclado US y desea emplear teclas muertas en la consola
puede usar desde la línea de comandos:

        doas wsconsctl -w keyboard.map+="keycode 40=dead_acute dead_diaeresis"
        doas wsconsctl -w keyboard.map+="keycode 41=dead_grave dead_tilde"
        doas wsconsctl -w keyboard.map+="keycode 56=Cmd2 Multi_key" 

o para que esta configuración siempre sea realizada durante el arranque
agregue estas líneas al final de `/etc/rc.local` (puede agregar al final
de cada línea `> /dev/null`).

Estas líneas configuran entre otros:

'

:   como tecla muerta para la tilde (seguido de un espacio producirá el
    apostrofe)

"

:   como tecla muerta para la diéresis (seguido de un espacio producirá
    las comillas)

\`

:   como tecla muerta para el acento grave (seguido de un espacio
    produce el apostrofe izquierdo)

\~

:   como tecla muerta para la virgulilla (seguido de un espacio produce
    \~)

\^

:   como tecla muerta para el acento circunflejo

Shift+Alt izquierdo

:   Como tecla de composición

La tecla de composición[^1] le permitirá generar un carácter empleando
una secuencia de dos teclas. Por ejemplo si presiona la tecla de
composición (i.e Shift+Alt izquierdo con la configuración presentada), y
después presiona ? seguido de ? obtendrá el carácter ¿. En el apendice
[Caracteres que pueden generarse](#caracteres-que-pueden-generarse)
encontrará una tabla con todas las combinaciones de teclas que pueden
usarse con la tecla compose y con teclas muertas.

### X-Window {#teclado-xwindow}

Dado que X-Window emplea el teclado en modo crudo la configuración que
haga para las consolas virtuales no quedará disponible.

Si tiene un teclado en español puede configurarlo con `xorgcfg` o bien
con `xorgcfg -textmode`, o bien editando el archivo `/etc/X11/xorg.conf`
para que en la sección del teclado quede la línea:

        Option  "XkbLayout" "es"
        

o si su teclado es latinoamericano remplace `es` por `latam`.

Si tiene un teclado en inglés puede agregar las siguientes líneas a su
archivo `~/.Xmodmap`

        keycode 64=Alt_L Multi_key
        keycode 48=dead_acute dead_diaeresis
        keycode 49=dead_grave dead_tilde 

y asegurarse de ejecutar `xmodmap ~/.Xmodmap` durante el arranque de su
sesión X (podría ser por ejemplo agregándolo a `~/.xsession`)

[^1]: Tecla de composición: en inglés *compose key*
