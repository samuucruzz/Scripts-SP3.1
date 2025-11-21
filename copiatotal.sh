#!/bin/bash

mes=$(date +"%B%Y")
tar -czf /backsamuel/CopTot-$mes.tar.gz /home
echo "Copia total del mes $mes ha sido creada correctamente" >> /backsamuel/logcopias.txt