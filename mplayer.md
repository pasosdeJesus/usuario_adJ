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
