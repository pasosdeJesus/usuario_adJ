syslog
------

`syslogd` es un servidor que recibe mensajes de depuración y trazas de
diversos programas. Su archivo de configuración es `/etc/syslog.conf`,
cada línea de este archivo especifica que hacer con los mensajes
recibidos por uno o más programas.

Tras modificar `/etc/syslog.conf` puede obligarse a `syslogd` a leerlo
de nuevo enviado la señal HUP, por ejemplo:

    # ps ax | grep syslogd
    7723 ??  Is      0:00.06 syslogd 
    # kill -HUP 7723
        

### Referencias y lecturas recomendadas {#referencias-syslog}

Las siguientes páginas man: syslog.conf 8, syslog 3, syslogd 8 y logger
1.
