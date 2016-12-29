### Chromium

Puede iniciarlo desde el menú de fluxbox o desde una terminal con
`chromium`.

Es posible que chrome use como proxy un tunel SOCKS creado con ssh. Esto
es útil por ejemplo para ingresar a sitios web que están en intranets.
Primero cree el tunel ingresando al cortafuegos/enrutador de la
Intranet, por ejemplo en el puerto 9080 con:

    ssh -D9080 miusuario@micortafuegos 
              

A continuación inicie chromium indicando que debe usarse el proxy socks
del puerto 9080:

    chromium --proxy-server=socks://127.0.0.1:9080
              

Tras esto ya podrá ingresar direcciones de la intranet desde el
navegador.
