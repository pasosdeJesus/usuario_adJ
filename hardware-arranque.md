Reconocimiento de hardware durante el arranque {#hardware-arranque}
----------------------------------------------

Durante el arranque el kernel detecta hardware usando diversos
controladores en cierto orden. El orden y los controladores que se usen
dependen de la configuración que se haya dado al kernel al compilarlo.
El orden típico configurado en el kernel genérico es:

-   Procesador, Memoria, BIOS

-   Discos duros, CDROM y unidades de disquete

-   Buses, Teclado, Dispositivos ISA

-   Puertos paralelos y seriales

-   Dispositivos ISA plug and play

La configuración de la mayoría de estos dispositivos puede ser
determinada por el controlador, pero con algunos dispositivos (e.g ISA,
ciertos teclados) el kernel incluye valores predeterminados que en
algunos casos pueden no corresponder al hardware o que por la forma de
detectar congelan el sistema completo. En tal caso, determine los
recursos que el dispositivo tiene configurados con jumpers o con
software (e.g IRQ, dirección de entrada salida base, DMA) y modifique
los valores que emplea el kernel de una de estas formas (en un caso
extremo puede tener que deshabilitar el dispositivo):

-   Arranque con `boot -c` y cambie parámetros usados por los
    controladores antes de continuar con la detección automática de
    hardware. El cambio sólo durará mientras no reinicie el sistema,
    puede hacer el cambio durable por ejemplo con el comando:
    `config -u`.

-   Después de que su sistema haya iniciado modifique los recursos
    asignados por defecto del kernel con `config -e -o /bsd.new /bsd`.

-   Recompile el kernel con una configuración apropiada.

### Modificación antes de arrancar {#modificacion-antes-de-arrancar}

Al arrancar, cuando esté en el prompt `boot>`, inicie con:

            boot> boot -c
          

Así entrará a un entorno interactivo, que le permite cambiar la
asignación de recursos predeterminada para algunos dispositivos. Por
ejemplo si tiene una tarjeta de red compatible NE2000 con dirección base
0x300 e IRQ 3, el controlador `ne` la asignará la interfaz `ne1` que por
defecto usa la dirección base 0x300 pero la IRQ 10. Desde el prompt que
`boot -c` produce ingrese:

            UKC> change ne1
          

puede ver otros comandos disponibles con el comando `help`. Una vez
complete la configuración salga del entorno interactivo con `quit`, tras
esto el kernel continuara la detección pero usando los cambios que haya
hecho.

Una vez haya configurado los recursos que un controlador emplea para que
correspondan a los de un dispositivo y que su sistema esté operando,
puede hacer el cambio permanente usando:

        doas config -e -o /bsd.ne1 -u /bsd
          

que le permitirá al mismo entorno interactivo, que procurará detectar
los cambios que usted haya podido hacer durante el arranque, le
permitirá completarlos y cuando salga (con `quit`) escribirá un nuevo
kernel `/bsd.ne1` con la misma configuración de `/bsd` pero con sus
cambios aplicados.

Si no logra configurar algún dispositivo y esto hace que el sistema
completo se congele durante el arranque, puede requerir deshabilitar el
dispositivo (situación que es muy inusual).

### Lecturas recomendadas {#hardware-arranque-lecturas}

-   Página del manual unix de autoconf8. `autoconf` determina el orden y
    los controladores que se usan para la detección automática de
    hardware.

-   Página del manual unix de boot\_config y de 8 donde se describen los
    comandos aceptados por el entorno interactivo de configuración de
    dispositivos.

-   Puede encontrar más sobre la secuencia de arranque de OpenBSD por
    ejemplo en [](http://dhobsd.pasosdeJesus.org/pres21abr2005/)


