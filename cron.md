`cron`: para programar tareas {#cron}
-----------------------------

El programa `cron` ejecuta tareas configuradas para correr en cierto(s)
momento(s). Este servico debe correr permanentemente. Puede comprar que
opera con `pgrep cron` que debe responder con el número del proceso. Si
no está corriendo debe ejecutarlo urgentemente bien reiniciando el
servido o ejecutando `doas cron`.

Cada minuto el programa `cron` busca tareas cuya ejecución esté
pendiente.
