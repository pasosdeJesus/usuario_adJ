pdksh (ksh) {#pdksh}
-----------

Es un interprete de comandos similar a `bash`. Este interprete de
comandos al iniciarse como interprete de login lee los archivos
`/etc/profile` y `$HOME/.profile`, pero no lo hace si es iniciado como
interprete interactivo. Puede iniciarse explícitamente como interprete
de login con `ksh -l`. Esto puede resultar útil para iniciarlo por
ejemplo dentro de `xterm`:

        xterm -en utf8 -e /bin/ksh -l 

El método de edición (`vi`,`emacs` o `gmacs`) se configura en la
variable `VISUAL`.
