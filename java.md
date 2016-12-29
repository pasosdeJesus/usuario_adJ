### Java

Desde OpenBSD 4.7 se incluyó un porte oficial de Java de fuentes
abiertas, se trata del `jdk-1.7`.

Si requiere versiones anteriores de Java o si requiere el plugin para
Firefox deberá compilar una versión anterior.

#### Compilación de JDKs de fuentes cerradas {#compilacion}

Las versiones anteriores a la 1.7, deben compilarse como portes (de
subdirectorios de `/usr/ports/devel/jdk/`), pues las licencias de las
fuente exigen que al descargar de las mismas las haga directamente de
los sitios de distribución. Al intentar compilar cada uno podrá ver
instrucciones que le indican de donde descargar las fuentes para
ubicarlas en `/usr/ports/distfiles`.

Tras descargar manualmente las fuentes, la compilación e instalación son
directas (i.e con `make` y `make install` respectivamente). Tenga en
cuenta que los portes del jdk para su compilación requieren que la capa
de emulación de Linux esté activada (ver [???](#emulacion-linux)).

Si por ejemplo instala `jdk-1.4` los binarios quedarán en
`/usr/local/jdk1.4/bin/` así que es recomendable que agregue tal ruta a
su variable `PATH` por ejemplo en su archivo `~/.profile` o el
equivalente.

#### Plugin de Java para Mozilla y Firefox {#plugin-java}

El `jdk-1.4` incluye un plugin que puede emplearse con `mozilla` o
`mozilla-firefox`. Basta ejecutar:

        cd  ~/.mozilla
        mkdir plugins
        cd plugins
        ln -s /usr/local/jdk-1.4.2/jre/plugin/i386/ns610/libjavaplugin_oji.so .

después reiniciar `mozilla-firefox` y verificar que el plugin esté
operando abriendo el URL `about:plugins`. Como se indica en
http://archives.neohapsis.com/archives/openbsd/2005-09/2253.html, para
que puedan cargarse applets es necesario aumentar el límite de memoria
para datos con algo como:

        ulimit -d 2000000

que de requerirse puede ejecutarse desde la cuenta root (cuyo límite
máximo es mayor que el de cuentas de usuario).
