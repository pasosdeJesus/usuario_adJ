#!/bin/sh
# Extrae versiones extra de algunos paquetes


echo '<?xml version="1.0" encoding="ISO-8859-1"?>' > masversiones.ent
echo '' >> masversiones.ent

# ruby
rubymayor=`ruby -v | sed -e "s/ruby \([0-9]\).\([0-9]\).*/\1.\2/g"`
echo "<!ENTITY rubymayor \"$rubymayor\">" >> masversiones.ent

rubymayorsinpunto=`echo $rubymayor | sed -e "s/[.]//g"`
echo "<!ENTITY rubymayorsinpunto \"$rubymayorsinpunto\">" >> masversiones.ent


# vim
dirvim=`grep vim-[0-9] infoversion.ent | sed -e "s/.*vim-\([0-9]\)\.\([0-9]\).*/vim\1\2/g"`
if (test ! -f "/usr/local/share/vim/$dirvim/vimrc_example.vim") then {
  echo "Se esperaba /usr/local/share/vim/$dirvim/vimrc_example.vim referenciado en conf-programas";
  exit 1;
} fi;

echo "<!ENTITY dirvim \"$dirvim\">" >> masversiones.ent
