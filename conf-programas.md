# Configuracioń y uso de algunos programas {#conf-programas}

## Escritorio y Archivos {#escritorio}

### FluxBox

La operación básica de este liviano y estético administrador de 
ventanas se describe en [???](#basico_adJ), aquí describimos algunos 
detalles de configuración.

Para emplearlo como administrador de ventanas por defecto debe
modificarse `~/.xsession`, así como en `~/.xinitrc` y agregar al final:

        if (test -x /usr/local/bin/startfluxbox) then {
            /usr/local/bin/startfluxbox
        } fi; 

Una vez en operación podrá realizar diversas configuraciones oprimiendo
el botón derecho sobre el escritorio en el menú `fluxbox menu`. Por
ejemplo podrá cambiar estilos en `System Styles` y esconder/mostrar la
barra de herramientas con `Configure -> Toolbar -> Visible` FluxBox
ejecutando `xfig`

Entre sus características:

-   Es altamente configurable (recursos, menús, decoración de ventanas y
    estilos).

-   Es muy liviano, requiere alrededor de 4MB en RAM.

-   Con Alt+\[Boton izquierdo\] permite cambiar ubicación de la ventana
    sobre la que está el curso, y con Alt+\[Botono derecho\] el tamaño.

El menú que presenta se configura en un archivo texto con una sintaxis
sencilla, puede cambiarse editando en `~/.fluxbox/menu`.

Los programas que se inician con el escritorio pueden configurarse en
`~/.fluxbox/startup`. Por ejemplo en este archivo puede configurar el
locale que usará agregando o cambiando la línea:

    export LANG=es_CO.UTF-8
        

La apariencia en general puede configurarse en `~/.fluxbox/init`

Puede configurar teclas rápidas en el archivo `~/.fluxbox/keys`

#### Lecturas recomendadas {#lecturas-conf-fluxbox}

-   Sitio oficial [](fluxbox.org).

-   Página sobre fluxbox de NetBSD [](http://wiki.netbsd.org/fluxbox/)

-   Página sobre fluxbox de Gentoo
    [](http://www.gentoo.org/doc/es/fluxbox-config.xml)


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


## Espiritualidad {#espiritualidad}
            
### `xiphos`

Como se describe en [???](#xiphosmanual), es una herramienta gráfica de
estudio e investigación bíblica que se basa en las librerías del
proyecto Sword.

Puede iniciarla desde el menu de fluxbox Espiritualidad-&gt;Xiphos o
desde una terminal con `xiphos`. Deben instalarse módulos primero. Cada
módulo puede ser una traducción, comentario, diccionario. Hay
traducciones a muchos idiomas (incluyendo manuscritos griegos y hebreo).
En español entre otras se encuentra parte de la traducción de dominio
público de los evangelios que típicamente se ha incluido con adJ.

Una vez instale los módulos que desea usar, es posible ver varias
traducciones en paralelo. Cada traducción puede contar con opciones
como: Palabras de Cristo en Rojo, Números Strong, Etiquetas
morfológicas, Notas al pie, encabezados.

## Preparación de Documentos y Aplicaciones de Oficina {#documentos}

### Aplicaciones estilo MS-Office {#msoffice}

LibreOffice es un juego de aplicaciones de oficina que ofrece,
prácticamente, la misma funcionalidad de MS-Office, un formato de
documentos estándar (ISO) y facilidades para importar y exportar en
formatos de MS-Office.

Lo puede iniciar desde el escritorio con botón derecho [Oficina &gt;
LibreOffice]{.menuchoice} o bien desde una terminal con

        soffice
              

Después de instalarlo y ejecutarlo por primera vez arrancará en inglés,
para configurarlo en español vaya al menú [Tools &gt; Options &gt;
Language]{.menuchoice} y elija Español y Español/Colombia en las
casillas de idioma que aparecen al lado derecho.

Incluye el procesador de texto `writer` (que puede iniciar desde una
terminal con `swriter`), la hoja de cálculo `calc` (que inicia desde una
terminal con `scalc`), el creador de presentaciones `impress` (que
inicia con `simpress` desde un terminal) y el programa para diagrama
`draw` (que puede iniciar con `sdraw`). Puede aprender más sobre este
procesador en [???](#libreoffice-basico)

Además el DVD de adJ incluye P-ABIWORD como procesador de texto capaz de
abrir y escribir tanto en el formato de Microsoft Office como en
OpenDocument (que es el formato de LibreOffice y OpenOffice).

Para operar con hojas de cálculo incluye P-GNUMERIC, que también puede
abrir y guardar en OpenDocument y en formatos de Microsoft Office.

La funcionalidad de un procesador de palabra, así como la básica para
hacer presentaciones también las ofrece LaTeX (ver [???](#latex)). Parte
de la funcionalidad de una hoja de cálculo la tiene desde una terminal
`sc`. También puede usar `magicpoint` para hacer presentaciones. Sin
embargo para usar estas herramientas se requiere aprender formas
diferentes de operar.


### TeX y Ghostview {#conf-tex-gv}

Para emplear TeX, LaTeX y asociados instale texlive y gv:

        doas pkg_add $PKG_PATH/P-TEXLIVE_BASE.tgz 
        doas pkg_add $PKG_PATH/P-TEXLIVE_TEXMF-FULL.tgz 
        doas pkg_add $PKG_PATH/P-GV.tgz 

Puede configurar tamaño del papel, separado en sílabas y otros detalles
con `texconfig`.

A continuación se incluye un mini-tutorial de LaTeX adaptado de AALinux,
por otra parte puede consultar algo más sobre `gv` en la sección
[???](#uso-impresora).

#### LaTeX

LaTeX es una extensión a un sistema llamado TeX, desarrollado para
escribir documentos de matemáticas. A continuación se presenta un
ejemplo de un documento LaTeX y el resultado que se obtiene tras
procesarlo.

    \documentclass{article}
    \usepackage[T1]{fontenc}
    \usepackage[spanish]{babel}
    \begin{document}
    \author{Rupertino Gonzales}
    \title{Algunas posibilidades de LaTeX}
    \maketitle

    \section{Elementos}
    Puede estructurar el documento en capítulos, secciones, etc.
    Este texto es el contenido de la primera sección de este ejemplo, 
    puede escribir cada párrafo en líneas consecutivas.

    \subsection{Ayudas}
    Puede lograr efectos como \emph{Itálicas}, \textbf{negrillas} o 
    cambios en el \textsf{tipo o {\small tamaño} de letra} (note 
    como se anidaron ambientes en este ejemplo).

    Puede crear listas:
    \begin{itemize}
    \item Primer elemento de lista.
    \item Segundo elemento de lista.
    \end{itemize}
    o tablas
    \\
    \begin{tabular}{|l|r|} \hline
    Título 1 & Título 2 \\\hline
    elemento 1 & elemento 2 \\\hline
    \end{tabular}
    \subsection{Ecuaciones}
    LaTeX es un experto en esta materia:
    \[ \int_{x=-\infty}^{\infty}e^{-|x|} \]
    \end{document}

section
Comando de LaTeX para iniciar una sección.

emph
Comando de LaTeX para ambiar tipo de letra a itálicas.

textbf
Comando de LaTeX para cambiar tipo de letra a negrilla.

LaTeX ofrece plantillas para varios tipos de documentos: artículo,
reporte, libro y ofrece el concepto de ambiente para indicar como
presentar cierta información de acuerdo a la plantilla. En el ejemplo
presentado, el tipo de documento es artículo (lo indica la línea
`documentclass{article}`), y uno de los ambientes empleados es
`tabular`, que genera una tabla.

Una vez edite un documento puede procesarlo con LaTeX para obtener un
archivo DVI, por ejemplo para generar el archivo `documento.dvi` a
partir de `documento.tex`:

        latex documento.tex

latex
Programa que convierte un archivo LaTeX a DVI.

xdvi
Programa para ver un archivo DVI en pantalla.

El archivo DVI es apropiado para imprimir, puede imprimirlo con un
comando como `dvilj`, `dvidj` o un nombre análogo que corresponda a su
impresora [^1]. Para visualizar un archivo DVI puede emplear el comando
xdvi:

        xdvi documento.dvi

dvi2ps
Programa para convertir un DVI en PostScript.

y para convertirlo a PostScript puede emplear `dvi2ps`:

        dvi2ps -c documento.ps documento.dvi

A continuación se presenta como se ve el ejemplo de esta sección con el
programa `xdvi`.

![Visualización de DVI generado de fuente en LaTeX](ejlatex.eps)

Existen además otros programas para convertir de LaTeX a HTML como
latex2html y HeVeA. Puede encontrar más información de latex2html en
[](http://ctan.tug.org/ctan/tex-archive/support/latex2html/) y de HeVeA
en [](http://pauillac.inria.fr/hevea/).

[^1]: Si usa `ksh` puede ver una lista de posibles programas que le
    permitan imprimir, tecleando `dvi` desde un intérprete de comandos y
    presionando Tab dos veces.


### DocBook

Puede configurarse tanto DocBook SGML 4.4 y procesarse con las hojas de
estilo DSSSL, o bien DocBook XML 4.4 y procesarse con `xsltproc`.

#### SGML 4.4 con DSSSL {#sgml-4-4-con-dsssl}

Instale los paquetes openjade, docbook y docbook-dsssl:

        doas pkg_add $PKG_PATH/P-DOCBOOK.tgz
        doas pkg_add $PKG_PATH/P-DOCBOOK-DSSSL.tgz
        doas pkg_add $PKG_PATH/P-OPENJADE.tgz 

Esto bastará para hacer conversiones de DocBook SGML a HTML por ejemplo
si su hoja de estílo DSSL es "marcos.dsl" y va a convertir el documento
DocBook marcos.xml:

        openjade  -t sgml -ihtml -d marcos.dsl#html marcos.xml 

Para convertir a PostScript además de los paquetes anteriores requiere
el paquete texlive (ver [TeX y Ghostview](#conf-tex-gv)) y el paquete
jadetex

#### XML 4.4 con XSL {#xml-4-4-con-xsl}

Cómo parte del paquete `` se instalará el DTD de DocBook XML 4.4 en el
directorio `/usr/local/share/xml/docbook`. Es recomendable que cree el
archivo `/usr/local/share/xml/catalog` inicialmente con:

        CATALOG "docbook/catalog" 

y que agregue en este archivo la ruta de otros catálogos XML o de DTDs.

Para transformar documentos XML con hojas de estilo XSL puede emplear un
procesador como `xsltproc`, que está incluido en el paquete `libxslt`.
Esta herramienta recibe el nombre del archivo XSL y el nombre del
archivo XML por transformar. También puede recibir la opción
`--catalogs` que indica usar los catálogos de la variable
`SGML_CATALOG_FILES` (se separan unos catálogos de otros con el carácter
':'), o la opción `--nonet` que indica no descargar DTDs de Internet
(los catálogos deben resolver todos los identificadores públicos).

Las hojas de estilo XSL para transformar DocBook XML en HTML y en XML-FO
(Formatting objects, apropiado para imprimir con un procesador FO) se
instalan con el paquete `` y quedan en `/usr/local/share/xsl/docbook`.

Una vez instalados todas las partes puede procesar el archivo
`ejemplo.xdbk`:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"  "/usr/local/share/xml/docbook/4.4/docbookx.dtd" > 

    <article lang="es">
        <title>articulo</title>
      <articleinfo>
        <authorgroup>
          <author>
        <firstname>Nombres</firstname>
        <surname>Apellidos</surname>
        <authorblurb>
              <para><address>
              <email>micorreo@pasosdeJesus.org</email>
               </address></para>
        </authorblurb>
          </author> 
        </authorgroup>
        
        <abstract>
            <para>Resumen</para>
        </abstract>

        <legalnotice>
            <para>nota legal</para>
        </legalnotice>

      </articleinfo>

      <sect1 id="s1">
        <title>Primera sección</title>

        <para>Parrafo</para>
      </sect1>
    </article>

con una hoja XSLT de DocBook con:

        export SGML_CATALOG_FILES="/usr/local/share/xml/catalog"
        xsltproc --catalogs --nonet /usr/local/share/xsl/docbook/html/chunk.xsl ejemplo.xdbk

## Español {#espanol}

### ispell

`ispell` permite revisar ortografía de textos planos o fuentes de
documentos en diversos formatos (HTML, XML o TeX). Hay diccionarios
disponibles para diversos idiomas. Al instalar el paquete `ispell` se
instalarán dos diccionarios: inglés de EUA (`american`) e inglés de
Inglaterra (`british`). Para emplear el diccionario en español
(`spanish`) instale el paquete `ispell-spanish`, puede configurarlo como
diccionario por defecto con `ispell-config`.

#### Corrección ortográfica {#correccion-ortográfica}

Puede corregir interactivamente la ortografía de un texto plano (digamos
`carta.txt`) usando el diccionario por defecto con:

        ispell carta.txt
                

o si desea emplear el diccionario de un idioma particular:

        ispell -d spanish carta.txt
                

Al corregir interactivamente `ispell` mostrará palabras que no encuentre
en el diccionario del idioma ni en su diccionario personal[^1] del
idioma (e.g. `~/.ispell_spanish`), así como posibles remplazos. Podrá
elegir uno de los remplazos tecleando el número que antecede al
remplazo.

[^1]: Puede cambiar el diccionario personal que `ispell` debe emplear
    con la opción `-p 
                            archivo`

## Multimedia {#multimedia}

### Mplayer

Es un reproductor de audio y video que soporta gran variedad de
formatos. Por ejemplo para ver video.flv:

        mplayer video.flv
              

Se distribuye con codecs que pueden distribuirse libremente. Para que
soporte codecs de Windows es importante instalar también el paquete
`win32-codecs`

También permite hacer conversiones y extraer partes. Por ejemplo para
extraer pista de audio de un video descargado de youtube, y dejarla en
formato WAV:

        mplayer -vo null -ao "pcm:file=pista.wav" -af resample=44100 "video.flv"
        

Para reproducir 10 segundos de un DVD comenzando en el segundo 240:

        mplayer -ss 240 -endpos 10 dvd://1
        

Se distribuye junto con `mencoder` que permite convertir de un formato a
otro.

### Edición de gráficos {#ediciongraficos}

Para ver una gráfica (sin editarla) prácticamente en cualquier formato,
puede usar `display` incluido en P-IMAGEMAGICK:

    display migrafica.png
              

Otra opción que facilita ver un directorio con imagenes es `xfi`
incluido en el paquete P-XFE:

    xfi migrafica.png
              

Las operaciones típicas con gráficos son el retoque de fotos y la
creación de diagramas. Para retocar fotografías se emplean editores
gráficos a nivel de pixels, mientras que para creación de diagramas
resultan más convenientes editores de gráficos vectoriales.

Como editor de gráficos a nivel de pixels, el CD de adJ incluye P-GIMP

Como editor vectorial incluye P-INKSCAPE

![](inkscape.eps)

OpenOffice incluye otro editor vectorial llamado draw.

Para la generación de gráficos de barras y estadísticos resulta más
apropiado el graficador de P-GNUMERIC o de calc --la hoja de cálculo de
OpenOffice--, ver [???](#msoffice)


### Edición de audio {#edicionaudio}

Para reproducir una pista de audio en diversos formatos (incluyendo el
libre ogg, el común wav y el patentado mp3) puede usar `mplayer` (ver
[???](#mplayer)), o bien `audacious` (incluido en el paquete
P-AUDACIOUS): El programa `play` incluido en el paquete P-SOX también le
permitirá escuchar diversos formatos.

Desde la línea de comandos podrá recortar, cambiar volumen y aplicar
otros efectos empleando el programa `sox`.

Si prefiere un editor gráfico que le permite recortar y aplicar algunos
efectos a pistas de audio en prácticamente cualquier formato de audio
utilice el programa P-AUDACITY:

## Operación en red {#operación-en-red}

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

## Ambiente de Desarrollo {#ambiente-de-desarrollo}

### Ruby

En adJ es sencillo usar P-RUBY con Ruby on Rails 5. Lo básico se instala
de paquetes de OpenBSD y lo más reciente de Ruby directamente como
gemas.

#### Instalación y configuración

Asegúrese de tener instalados los paquetes P-RUBY, P-LIBV8 y P-NODE,
incluidos en el DVD de adJ 5.9

Asegúrese de tener enlaces al interprete de ruby y herramientas (como
describe el paquete ruby):

    doas sh
    ln -sf /usr/local/bin/ruby23 /usr/local/bin/ruby
    ln -sf /usr/local/bin/erb23 /usr/local/bin/erb
    ln -sf /usr/local/bin/irb23 /usr/local/bin/irb
    ln -sf /usr/local/bin/rdoc23 /usr/local/bin/rdoc
    ln -sf /usr/local/bin/ri23 /usr/local/bin/ri
    ln -sf /usr/local/bin/rake23 /usr/local/bin/rake
    ln -sf /usr/local/bin/gem23 /usr/local/bin/gem
                  

##### Límites amplios

Asegurarse de tener limites amplios del sistema operativo para abrir
archivos y manejar memoria, por ejemplo superiores a los siguientes en
`/etc/systctl.conf`

    kern.shminfo.shmmni=1024
    kern.seminfo.semmns=2048
    kern.shminfo.shmmax=50331648
    kern.shminfo.shmall=51200
    kern.maxfiles=20000

El usuario desde el cual desarrollará o ejecutará aplicaciones también
debe tener límites amplios, en particular su clase de login (por ejemplo
`staff`). Debe tener al menos los siguientes en `/etc/login.conf`

    staff:\
            :datasize-cur=1536M:\
            :datasize-max=infinity:\
            :maxproc-max=4096:\
            :maxproc-cur=4096:\
            :openfiles-max=8090:\
            :openfiles-cur=8090:\
            :ignorenologin:\
            :requirehome@:\
            :tc=default:

(Si modifica el archivo `/etc/login.conf` debe reconstruir su versión
binaria con `doas cap_mkdb /etc/login.conf`).

##### irb

Para facilitar su exploración del lenguaje ruby, puede usar `irb` (ver
{4}), pero antes verifique que su archivo `~/.irbrc` tenga las
siguientes líneas (añadidas por defecto en adJ a la cuenta de
administrador):

    # Configuración de irb
    # Basado en archivo de comandos disponible en <http://girliemangalo.wordpress.com/2009/02/20/using-irbrc-file-to-configure-your-irb/>
    require 'irb/completion'
    require 'pp'
    IRB.conf[:AUTO_INDENT] = true
    IRB.conf[:USE_READLINE] = true

    def clear
        system('clear')
    end

A continuación ingrese a `irb` y escriba por ejemplo `4.` y presione la
tecla \[Tab\] 2 veces para ver los métodos de la clase Integer.

##### Gemas

El paquete `ruby` incluye `rubygems` que manejan gemas (es decir
librerías) con el programa `gem`. Puede actualizar a la versión más
reciente con:

    doas gem update --system
    QMAKE=qmake-qt5 make=gmake MAKE=gmake doas gem pristine --all

##### Bundler

Para facilitar el manejo de varias gemas en un proyecto es típico
emplear `bundler` que instala con:

    doas gem install bundler

Configurelo para que instale gemas para un usuario en `/var/www/bundler`
(así evitará problemas de permisos y la dificultad de bundler para usar
`doas` en lugar de `sudo`):

    bundler config path /var/www/bundler

Puede experimentar descargando un proyecto para ruby ya hecho,
seguramente verá un archivo `Gemfile`, donde bundler examina de que
librerías depende la aplicación y genera un archivo `Gemfile.lock` con
las versiones precisas por instalar de cada gema.

Una vez tenga un proyecto puede instalar las gemas de las que depende
con `bundle install`

Si eventualmente no logra instalar algunas --por problemas de permisos
tipicamente-- puede instalar con `doas` e indicar la ruta de las gemas
locales, por ejemplo:

    doas gem install --install-dir /var/www/bundler/ruby/2.3/ bcrypt -v '3.1.11'

##### Rails

Se trata de una popular gema que facilita mucho crear sitios web
dinámicos.

Para instalarla globalmente (en `/usr/local/bin` y
`/usr/local/lib/ruby/gems/`) la versión estable más reciente de Rails
(5.0.0 en el momento de este escrito), ejecute

    doas gem install rails

Rails requiere en el servidor un interprete de JavaScript, por lo que
recomendamos `node.js` (ver {1}) incluido en el DVD de adJ VER-ADJ y que
se configurará automáticamente.

La gran mayoría de gemas usadas por rails instalarán de la misma forma
que se explicó. Algunos casos especiales son:

-   `nokogiri` que puede requerir

        doas gem install --install-dir /var/www/bundler/ nokogiri -- --use-system-libraries 
                    

-   `capybara-webkit` que podría requerir

        QMAKE=qmake-qt5 MAKE=gmake doas gem install capybara-webkit

##### Editor vim

Para emplear `vim` como editor se recomienda asegurarse de haber
ejecutado:

    cd ~
    mkdir -p .vim
    cd .vim
    cp -rf /usr/local/share/vim/vim74/* .
        

y si no tiene archivo \~/.vimrc ejecutar:

    cp /usr/local/share/vim/vim74/vimrc_example.vi ~/.vimrc
        

asi como agregar el archivo `~/.vim/ftplugin/ruby.vim` las siguientes
líneas:

    setlocal shiftwidth=2
    setlocal tabstop=2
    set expandtab   
        

#### Documentación

Puede aprender por ejemplo con los tutoriales interactivos de
<https://rubymonk.com>

En Internet puede ver la referencia oficial de las clases en:
<http://ruby-doc.org/core-2.1.5/Integer.html>

Y es buena referencia para Ruby, Rails y Rspec (incluidos cambios entre
una versión y otra y comentarios) es: <http://apidock.com/>

Podrá consultar documentación del núcleo, librería estándar y gemas
instalando el paquete `ruby-ri_docs` y ejecutando `ri` seguido de la
clase (por ejemplo `ri Float`) o sin parámetro ingresa a una consola que
da la posibilidad de autocompletar presionando Tab (por ejemplo pruebe
tecleando `Float` y después Tab dos veces).

También podrá ver la documentación de las gemas en formato Rdoc
ejecutando:

    gem server
        

y con un navegador consultando <http://localhost:8808>

#### Uso

##### Nueva aplicación usando SQLite

Genere una nueva aplicación:

    rails new aplicacion
    cd aplicacion
    bundle install
                

Esto creará una nueva aplicación de ejemplo e instalará todas sus
dependencias. Las gemas que no logre instalar por falta de permisos,
como se explicó anteriormente instalelas con `doas gem install` y la
opción `--install-dir /var/www/bundler/`

Una vez haya logrado que `bundle install` se ejecute completo puede
ejecutar:

                rails server
            

Tras esto puede ver con un navegador la aplicación en el puerto 3000 del
computador donde instaló: <http://127.0.0.1:3000/>

Notará que se generan los siguientes directorios y archivos:

  Archivo/Directorio                                  Descripción
  --------------------------------------------------- -----------------------------------------------------------------------------------
  README.rdoc                                         Documentación en formato Rdoc (puede cambiarse por README.md en formato Markdown)
  Rakefile                                            Tareas para `rake` (algo análogo a `make`)
  config.ru                                           Configurar servidor web por usar
  .gitignore                                          Archivos por ignorar en control de versiones
  Gemfile                                             Gemas requeridas
  app/assets/javascripts/application.js               Plantilla de Javascript para aplicación
  app/assets/stylesheets/application.css              Plantilla de CSS para aplicación
  app/controllers/application\_controller.rb          Plantilla del controlador de la aplicación
  app/helpers/application\_helper.rb                  Ayudas para construir vistas (sin lógica del modelos).
  app/views/layouts/application.html.erb              Plantilla por defecto para el sitio
  app/assets/                                         Datos estáticos de la página
  app/assets/images/                                  Gráficos de la aplicación (tipicamente que no se sirven estáticos)
  app/mailers/                                        Controlador para enviar correos
  app/models/                                         Modelos
  app/channel/                                        Controlador de websockets
  app/jobs/                                           Maneja cola de tareas programadas
  app/mailer/                                         Facilita envío y recepción de correos
  app/controllers/concerns/                           Código que se repite en controladores
  app/models/concerns/                                Código que se repite en modelos
  bin/bundle                                          Maneja dependencias con el ambiente de la aplicación
  bin/rails                                           Maneja posibilidades de generación y controles Rails
  bin/rake                                            Maneja tareas definidas en `Rakefile` y `lib/tasks`
  bin/setup                                           Plantilla de un configurador de la aplicación
  config/routes.rb                                    Rutas
  config/application.rb                               Configura aplicación
  config/environment.rb                               Configura ambiente
  config/secrets.yml                                  Para verificar integridad de galletas firmadas
  config/environments/development.rb                  Configuración ambiente de desarrollo
  config/environments/production.rb                   Configuración ambiente de producción
  config/environments/test.rb                         Configuración ambiente de pruebas
  config/initializers/assets.rb                       Configura recursos
  config/initializers/backtrace\_silencers.rb         Inhibe trazas de algunas librerías
  config/initializers/cookies\_serializer.rb          Configura como serializar galletas
  config/initializers/filter\_parameter\_logging.rb   Parametros por filtrar (no dejar) en bitácoras
  config/initializers/inflections.rb                  Inflecciones singular/plural
  config/initializers/mime\_types.rb                  Registra tipos MIME
  config/initializers/session\_store.rb               Configura donde se almacena sesión
  config/initializers/wrap\_parameters.rb             Configuración para ActionController::ParamsWrapper
  config/locales/en.yml                               Localización en inglés
  config/boot.rb                                      Prepara rutas para encontrar gemas
  config/database.yml                                 Configuración de base de datos
  config/puma.rb                                      Configuración de servidor web puma
  db/seeds.rb                                         Datos iniciales para base de datos
  lib/tasks/                                          Tareas para `rake`
  lib/assets/                                         "Activos" comunes para librerías
  log/                                                Bitácoras
  public                                              Archivos estáticos
  public/404.html                                     Mensaje por defecto para páginas no encontradas
  public/422.html                                     Mensaje por defecto para rechazar cambios
  public/500.html                                     Mensaje por defecto cuando ocurren errores en servidor
  public/favicon.ico                                  Icono
  public/robots.txt                                   Puede evitar indexación por parte de motores de búsqueda
  test/fixtures                                       Datos para pruebas
  test/controllers                                    Pruebas a controladores
  test/mailers                                        Pruebas a controladores de envio de correo
  test/models                                         Pruebas a modelos
  test/helpers                                        Pruebas a funciones para ayudar a construir vistas
  test/integration                                    Pruebas de integración
  test/test\_helper.rb                                Pruebas funciones auxiliares
  tmp/                                                Temporales y cache
  vendor/assets/javascripts                           Fuentes Javascript para código de terceros
  vendor/assets/stylesheets                           Hojas de estilo para código de terceros

  : Archivos generados

##### Generar un recurso

Puede crear un primer recurso (digamos `Departamento`) con modelo,
controlador simple y vistas para operaciones CRUD y RESTful con:

    rails g scaffold Departamento nombre:string{500} latitud:float longitud:float fechadeshabilitacion:date
    rake db:migrate
                    

Tras esto y volver a iniciar el servidor (más breve con `rails s`) podrá
realizar las operaciones básicas sobre departamentos desde:
<http://127.0.0.1:3000/departamentos/>

El `scaffold` genera tablas (con una migración), modelo, controlador,
vistas y rutas iniciales que con una interfaz muy simple le permitirán
listar departamentos, ver detalles de cada uno, crear nuevos, editar
existentes y eliminar.

Los archivos generados son:

  Archivo/Directorio                                    Descripción
  ----------------------------------------------------- ----------------------------------------------
  `db/migrate/20160320131555_create_departamentos.rb`   Migración para crear tabla
  `app/models/departamento.rb`                          Modelo
  `test/models/departamento_test.rb`                    Prueba al modelo
  `test/fixtures/departamentos.yml`                     Datos para pruebas
  `app/controllers/departamentos_controller.rb`         Controlador
  `app/views/departamentos`                             Vistas
  `app/views/departamentos/index.html.erb`              Lista de departamentos
  `app/views/departamentos/edit.html.erb`               Formulario para editar
  `app/views/departamentos/show.html.erb`               Muestra un departamento
  `app/views/departamentos/new.html.erb`                Nuevo departamento
  `app/views/departamentos/_form.html.erb`              Formulario usado por `edit` y `new`
  `test/controllers/departamentos_controller_test.rb`   Pruebas al controlador
  `app/helpers/departamentos_helper.rb`                 Funciones auxiliares para construir vistas
  `app/views/departamentos/index.json.jbuilder`         Lista en JSON
  `app/views/departamentos/show.json.jbuilder`          Muestra un departamento en JSON
  `app/assets/javascripts/departamentos.coffee`         Donde agregar código Coffescript para vistas
  `app/assets/stylesheets/departamentos.scss`           Para poner CSS de las vistas
  `app/assets/stylesheets/scaffolds.scss`               Para poner CSS de las vistas

  : Archivos generados con scaffold

Por convención de Ruby on Rails:

-   Las fuentes del módelo quedan en
    app/models/departamento.rb
-   El nombre de la tabla será la forma plural del nombre del módelo
    (e.g
    departamentos
    )
-   La tabla incluirá automáticamente un campo id de tipo entero que se
    autoincrementa
-   La tabla incluirá automáticamente los campos
    created\_at
    y
    updated\_at
    de tipo
    datetime
    .
-   La tabla será creada con una migración (cuya fuente quedará en
    db/migrate/
    ) y el registro de las migraciones ya aplicadas se lleva en una
    tabla
    schema\_migrations
    creada automáticamente en la base de datos.

##### Página de inicio

La página inicial de su aplicación puede crearla generando un
controlador con vista, modificando la vista y especificando la ruta:

    rails g controller hogar
                

Que genera:

  Archivo/Directorio                            Descripción
  --------------------------------------------- ----------------------------------------
  `app/controllers/hogar_controller.rb`         Controlador
  `app/views/hogar`                             Vistas relacionadas con el controlador
  `test/controllers/hogar_controller_test.rb`   Pruebas
  `app/helpers/hogar_helper.rb`                 Funciones auxiliares para vistas
  `app/assets/javascripts/hogar.coffee`         Coffescript para vistas
  `app/assets/stylesheets/hogar.scss`           CSS para vistas

  : Archivos generados con `g controller hogar`

Modifique el controlador `app/controllers/hogar_controller.rb` para
indicar que tendrá un vista `index`:

    class HogarController < ApplicationController
      def index
      end
    end
                

Cree la vista `app/views/hogar/index.html.erb`:

    <article>
    <h1>Mi aplicación</h1>
    <para> Manejar <a href="/departamentos">Departamentos</a></para>
    </article>
                

Y en el archivo de configuración de rutas `config/routes.rb` añada:

    root "hogar#index"
                

Al modificar fuentes en general no necesita volver a lanzar el servidor
de rails, pero si modifica `config/routes.rb` o cualquier archivo fuera
del directorio `app` debe reiniciar el servicio.

Examine desde un navegador <http://127.0.0.1:3000/>. Verá lo que
escribió en `app/views/hogar/index.html.erb` en el ambiente HTML que
tenga diseñado en `app/views/layouts/application.html.erb`.

##### Interacción con la base de datos

Puede examinar la tabla creada e interactuar con la base de datos con la
interfaz texto de SQLite como se ejemplifca a continuación:

    $ rails dbconsole
    sqlite> .schema
    CREATE TABLE "departamentos" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "nombre"
    varchar(500), "latitud" float, "longitud" float, "created_at" datetime, "updated_at" datetime);
    CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
    CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version"
    );

##### Ayudas para usar una base de datos PostgreSQL existente:

Se recomienda emplear UTF8 como codificación de PostgreSQL (si emplea
otra codificación convierta sacando un respaldo eliminando la base,
volviendola a crear con `-E UTF8` y restaurando los datos).

-   Arregle la aplicación recién creada para que emplee PostgreSQL,
    modificando parámetros de base de datos en
    config/database.yml
    . Si crea una nueva aplicación:
        cd ..
        rails new prueba1 --database=postgresql
                    

-   Si lo requiere en otra terminal cree un usuario para la base de
    datos que será el que empleará desde su aplicación ruby:
        doas su - _postgresql 
        $ createuser -Upostgres -h/var/www/tmp prueba
        Shall the new role be a superuser? (y/n) n 
        Shall the new role be allowed to create databases? (y/n) y
        Shall the new role be allowed to create more new roles? (y/n) n 
        $ psql -h/var/www/tmp -Upostgres psql (9.3.6) Type "help" for help.
        postgres=# ALTER USER prueba1 WITH password 'miclave'; ALTER ROLE postgres=# $ exit
                    

-   Vuelva a las fuentes de la aplicación y modifique los parámetros de
    la base de datos editando
    conf/database.yml
    Ponga el usuario recién creado, la clave y en la especificación de
    cada una de las 3 bases de datos (desarrollo, pruebas y producción)
    agregue la ruta de la conexión al motor de bases de datos:
        host: /var/www/tmp/
                    

-   A manera de prueba de su configuración intente ingresar a un
    interprete de comandos para su base de datos con:
        rails dbconsole
                    

-   Si las tablas de la base de datos no emplean la convención para
    nomenclatura de Ruby on Rails (nombres de tabla en plural, clases en
    singular) agregue al archivo
    config/environment.rb
    :
        ActiveRecord::Base.pluralize_table_names=false
                        

    Además de esto para que las pruebas puedan operar seguramente deberá
    renombrar los archivos con datos de prueba del directorio
    tests/fixtures
    , y en lugar de dejar forma plural dejar forma singular. Si el
    nombre de tabla es muy diferente en el modelo puede usar
    self.table\_name = "cc"
    como se indica en {8}.
-   Para generar un volcado inicial de la base de datos en
    db/structure.sql
    (incluyendo características no portables de PostgreSQL a otros
    motores de bases de datos), agregue al archivo
    config/application.rb
    la línea
    config.active\_record.schema\_format=:sql
    y después ejecute la tarea rake apropiada (ver {4}):
        rake db:structure:dump
                    

-   Genere clases (módelos) en blanco en el directorio
    app/models
    para cada una de las tablas de su aplicación, por ejemplo para la
    tabla
    mitabla
    :
        rails generate model mitabla --migration=false --timestamp=false
                    

-   Cuando la aplicación esté en operación ActiveRecord tomará la
    estructura directamente de la base de datos, no de los modelos en
    sus fuentes. Sin embargo puede ser útil poner comentarios en esos
    modelos con los campos de cada tabla. Esto puede hacerse instalando
    la gema
    annotate
    con
    doas gem install annotate
    y ejecutando:
        annotate
                    

-   Si desea ayuda en la generación de controladores y vistas para sus
    tablas, instale
    doas gem install schema\_to\_scaffold
    , genere (puede ser momentaneamente) el archivo
    db/schema.rb
    con
    rake db:schema:dump
    y ejecute
    scaffold
    para ver las instrucciones que debe dar a rails para generar
    modelos, controladores y vistas para las tablas de la base de datos.

##### Detalles para tener en cuenta al migrar aplicaciones

RoR tiene sus propias convenciones respecto a SQL, nombres de tablas y
demás, en ocasiones puede ser mejor intercambiar datos JSON con una
aplicación ya existente que interactúe con la base de datos. Sin embargo
si desea emplear RoR tanto como pueda para interactuar con la base de
datos, tenga en cuenta:

-   Toda tabla creada y maneja por RoR se espera que tenga los campos
    created\_at
    y
    updated\_at
    de tipo
    datetime
    . Puede generar una migración que agregue estos campos digamos para
    la tabla
    intervalo
    con
    rails g migration addTiempoToIntervalo created\_at:datetime
    updated\_at:datetime
    tras lo cual debe editar la migración creada para asegurar que queda
    bien (por ejemplo pasando a singular la tabla si ese es su caso).
-   Por defecto cada tabla debe tener una única llave primaria de nombre
    id
    y tipo entero autoincremental. Esto puede cambiarse un poco --pero
    no del todo según {6}-- la sugerencia allí dada es definir la llave
    primaria en SQL en la migración, la cual debe incluir
    id:false
    y en el modelo agregar
    self.primary\_key=:campo\_llave\_primaria
    . Por ejemplo si la llave primaria de una tabla usuario debe
    id
    pero de tipo
    string
    , la migración será:
        create_table "usuario", id: false, force: true do |t| 
          t.string "id", limit: 15, null: false 
          t.string "nombre", limit: 50 ... 
          t.datetime "created_at" 
          t.datetime "updated_at" 
        end
        add_index "usuario", ["id"], name: "index_usuario_on_id", unique: true, using: :btree

    Y en el modelo
    app/models/usuario.rb
    debe quedar:
        class Usuario < ActiveRecord::Base
          ...
          self.primary_key=:id
        end

-   Aunque es posible insertar datos iniciales para algunas tablas en
    db/seeds.rb
    , los métodos por defecto de RoR emplearán un campo autoincremental
    para la identificación, puede insertarse directamente en SQL, como
    se explica en {7}, con:
        connection = ActiveRecord::Base.connection()
        connection.execute("INSERT INTO mitabla(id, nombre) VALUES ('id1', 'nom1')")

##### 4.3 Localización

Si su público objetivo habla principalmente español puede:

-   Instalar la gema
    rails-i18n
    que incluye traducción a español y otros idiomas de varias cadenas
    de Ruby on Rails
        doas gem install rails-i18n
                    

-   Agregar
    gem "rails-i18n"
    en su archivo
    Gemfile
    y ejecutar
        bundle update
                    

-   Configurar en
    config/application.rb
    :
        config.time_zone = 'America/Bogota'
        config.i18n.default_locale = :es
                    

-   Eventualmente corregir inflexiones singular/plural en
    config/initializers/inflections.rb
    , por ejemplo (ver {3}):
        ActiveSupport::Inflector.inflections do |inflect|
          inflect.irregular 'pais', 'paises'
        end
                    

#### Depuración

Como se explica en {5}, desde la aplicación en rails puede entrar a
depurar:

-   Instale la gema
    gem install byebug
-   \* Para activar el depurador en sitios en producción debe además
    inicar el servidor web con
    rails s --debugger
-   \* En el sitio de las fuentes donde quiere comenzar a depurar
    llamando la función
    debugger

Ruby también ofrece facilidades para medir tiempos como se resume en
{4}.

#### Referencias

-   {1}
    http://guides.rubyonrails.org/getting\_started.html
-   {2}
    http://stackoverflow.com/questions/7092107/rails-3-1-error-could-not-find-a-javascript-runtime
-   {3}
    http://stackoverflow.com/questions/5285048/rails-3-routing-singular-option
-   {4}
    http://www.caliban.org/ruby/rubyguide.shtml
-   {5}
    http://guides.rubyonrails.org/debugging\_rails\_applications.html
-   {6}
    http://stackoverflow.com/questions/1200568/using-rails-how-can-i-set-my-primary-key-to-not-be-an-integer-typed-column
-   {7}
    http://stackoverflow.com/questions/6223803/execute-sql-script-inside-seed-rb-in-rails3
-   {8}
    http://stackoverflow.com/questions/7542976/add-timestamps-to-an-existing-table
-   {9}
    http://stackoverflow.com/questions/4613574/how-do-i-explicitly-specify-a-models-table-name-mapping-in-rails

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
