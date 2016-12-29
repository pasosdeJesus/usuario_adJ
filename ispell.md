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
