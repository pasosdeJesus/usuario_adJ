#!/bin/sh
# Genera tabla de composición en OpenBSD
# Cedido al dominio público vtamara@informatik.uni-kl.de

if (test ! -f "/usr/src/sys/dev/wscons/wsksymdef.h") then {
	echo "Las fuentes de OpenBSD deben estar en /usr/src/";
	exit 1;
} fi;
grep "^#define.*KS_[^ 	]*[ 	]*" /usr/src/sys/dev/wscons/wsksymdef.h | \
tr "	" " " |\
sed -e "s/^.*#define KS_\([A-Za-z_0-9]*\).*\(0x[0-9a-f]*\).*/s|KS_\1([^A-Za-z0-9_])|%#\2;|g/g"  > chsymhex.sed

for i in `sed -e "s/.*0x\([0-9a-fA-F]*\).*/\1/g" chsymhex.sed ` ; do echo -n "s/0x$i;/"; (echo "ibase=16";echo $i | tr [a-z] [A-Z])|bc;  done | sed -e "s/$/;\/g/g" > chhexdec.sed

sed -f chhexdec.sed chsymhex.sed | sed -e 's/%#/\\\&#/g' | sed -e 's/(/\\(/g' | sed -e 's/)/\\)/g' | sed -e 's/|g$/\\1|g/g' > chsymdec.sed

echo "
<table frame='all'>
<title>Combinaciones de teclas utilizables con la tecla compose</title>
<tgroup cols='3' align='center' colsep='1' rowsep='1'>
<thead>
<row><entry>Tecla 1</entry> <entry>Tecla 2</entry> <entry>Caracter resultante</entry></row>
</thead>
<tbody>" > tabcompose.xdbk

awk '/KS_plus/ { table=1; } /};/ {table=0;} /.*/ { if (table==1) { print $0;} }' /usr/src/sys/dev/wscons/wskbdutil.c  | grep -v "dead" | sed -f chsymdec.sed | sed -e "s/{ {/<row><entry>/g" | sed -e "s/},$/<\/entry><\/row>/g" | sed -e "s/},/<\/entry><entry>/g" | sed -e "s/,/<\/entry><entry>/g" | sed -e "s/}/<\/entry><\/row>/g" >> tabcompose.xdbk

echo '</tbody>
</tgroup>
</table>' >> tabcompose.xdbk


