Instalación del resto de adJ {#instalacion-del-resto}
----------------------------

Tras instalar el sistema base y reiniciar su computador, puede ingresar
a la cuenta del usuario administrador que creó y puede completar la
instalación ejecutando desde una terminal:

        /inst-adJ.sh

Este procedimiento permite instalar y actualizar adJ, así que puede
ejecutarlo cuantas veces lo requiera para completar la instalación o una
actualización. El archivo de comandos `/inst-adJ.sh` lo guiará en la
instalación del resto del sistema con preguntas típicamente de si o no,
como se presenta en las siguientes capturas de pantalla de ejemplo: adJ
puede configurar por defecto 2 imagenes cifradas, una para almacenar
bases de datos de PostgreSQL (directorio `/var/postgresql` y otra para
almacenar copias de respaldo de la base de datos y otros datos que usted
requiera (directorio `/var/www/resbase`). Cada una de estas imagenes
tienen asociadas claves para cifrar y descifrar, estas claves debe
suministrarlas típicamente durante el arranque o posteriormente
ejecutando:

        /etc/init.d/montaencpos
        /etc/init.d/montaencres

El servidor web Apache será configurado con SSL por lo que debe dar
detalles para el certificado como se presenta en la siguiente captura de
pantalla.

Después es recomendable que consulte `man afterboot` que incluye una
lista de chequeo de cosas por hacer después de la instalación.
