#!/bin/bash

echo "Eliminando copia diferencial de esta fecha: $(date)" >> /backsamuel/logcopias.txt
# ELIMINO TODO EL CONTENIDO
rm -f /backsamuel/CopDif/Sem-*
echo "Copia eliminada" >> /backsamuel/logcopias.txt