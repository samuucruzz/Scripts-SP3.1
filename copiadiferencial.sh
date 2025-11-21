#!/bin/bash

semana=$(date +%U)
#COPIA CON TAR
tar -czf /backsamuel/CopDif/Sem-$semana.tar.gz /home
echo "Copia de la Semana $semana creada correctamente: $(date)" >> /backsamuel/logcopias.txt