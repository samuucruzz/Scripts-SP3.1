#!/bin/bash

PROGRAM_LIST="programas.txt" # Nombre de la lista de programas

# Se necesita ser root para desinstalar
if [ "$EUID" -ne 0 ]; then
  echo "Error: Debes ejecutar este script con 'sudo'."
  exit 1
fi

echo "--- Iniciando desinstalación de programas ---"

# cat lee el archivo y el bucle while read procesa cada linea.
cat "$PROGRAM_LIST" | while IFS= read -r programa; do

  # Quitar espacios extra y revisar si la linea no está vacía
  programa=$(echo "$programa" | xargs)
  if [ -z "$programa" ]; then
    continue # Si está vacía, saltar a la siguiente linea
  fi

  echo ""
  echo "Intentando desinstalar: $programa"

  # Usamos apt remove para desinstalar el paquete.
  # El flag -y acepta la confirmación automáticamente.
  # El comando apt remove es reconocido por el sistema Ubuntu.
  apt remove -y "$programa"

  # Comprobar si la desinstalación tuvo éxito
  if [ $? -eq 0 ]; then
    echo ">>> $programa ELIMINADO correctamente."
  else
    echo ">>> ERROR al eliminar '$programa' (puede que no esté instalado)."
  fi

done

echo ""
echo "--- Proceso de desinstalación terminado. ---"