Introducción {#introduccion}
============

OpenBSD es un sistema operativo tipo Unix de libre redistribución[^1].
Es descendiente directo de NetBSD que a su vez desciende de los sistemas
Unix desarrollados en la Universidad de Berkeley i.e. BSD[^2]. Sus
puntos más fuertes son estandarización (cumplir POSIX), seguridad y
criptografía. Para lograr seguridad los desarrolladores de OpenBSD 
continuamente examinan detalladamente (auditan) y mejoran el código 
fuente para descrubir fallas de seguridad[^3]. Este trabajo ha
permitido liberar varias versiones de OpenBSD desde hace más de 10 años
con tan sólo dos fallas de seguridad conocidas en los componentes
básicos, en la instalación por defecto (apropiada para un servidor
conectado a Internet).


Diferencias entre OpenBSD y Linux
---------------------------------

-   Linux soporta más hardware y cuenta con muchas más aplicaciones, sin
    embargo la autodetección de hardware de OpenBSD es mejor y este
    sistema cuenta con capas de emulación que permiten ejecutar algunas
    aplicaciones para Linux, BSD/OS, SVR4, IBCS2 y FreeBSD (en i386).

-   OpenBSD no ha sido diseñado como sistema operativo de escritorio,
    sino para manejar un servidor conectado a Internet de forma
    extra-segura, sin embargo diversos desarrolladores han buscado
    mejorar su usabilidad en el escritorio, como se presenta en este
    escrito.

    En particular la distribución [Aprendiendo de
    Jesús](http://aprendiendo.pasosdeJesus.org) busca personalizar
    OpenBSD como plataforma de comunicaciones y sistema de escritorio
    completo y usable.

-   Las fuentes de OpenBSD son en la humilde opinión del autor de este
    escrito más legibles y mejor documentadas, los mismos
    desarrolladores mantienen excelentes páginas man.

-   La licencia del kernel de OpenBSD y de la mayoría de componentes del
    sistema básico es BSD.

[^1]: La mayoría de los componentes básicos de OpenBSD están cubiertos
    por licencias tipo BSD, que permiten copia, redistribución,
    modificación, inclusión en programas con licencia diferente y exigen
    únicamente crédito.

[^2]: BSD es sigla de *Berkeley Software Distribution*.

[^3]: Algunas técnicas que emplean para mejorar las fuentes de los
    portes se describen en <http://www.openbsd.org/porting.html>
