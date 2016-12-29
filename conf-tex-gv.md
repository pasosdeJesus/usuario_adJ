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
