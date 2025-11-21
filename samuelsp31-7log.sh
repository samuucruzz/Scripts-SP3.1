#!/bin/bash

LOG_DIR="/var/log"
OUTPUT_FILE="errores_del_sistema.log" # Nombre de archivo diferente
KEYWORD_PATTERN="error|fail"          # Patrón de búsqueda

# Borra el archivo de salida anterior y añade un encabezado
echo "BUSCANDO ERRORES EN EL SISTEMA LINUX" > "$OUTPUT_FILE"
echo "===========================================" >> "$OUTPUT_FILE"
echo "Fecha: $(date)" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Recorre solo los archivos dentro del directorio /var/log/
# Usamos '*' para expandir a todos los nombres de archivos.
for log_file in "$LOG_DIR"/*; do
    # Comprueba si el elemento es un archivo regular y no un directorio
    if [ -f "$log_file" ]; then
        # Usamos grep para buscar las líneas con errores (ignorando mayúsculas/minúsculas)
        # y guardamos el resultado en una variable temporal.
        # -i: Ignorar mayúsculas/minúsculas.
        # -E: Usar expresiones regulares extendidas (para usar el operador '|' o).
        ERROR_CONTENT=$(grep -iE "$KEYWORD_PATTERN" "$log_file")
        
        # Si la variable no está vacía (es decir, sí se encontraron errores)...
        if [ -n "$ERROR_CONTENT" ]; then
            
            # === GENERAR SALIDA CLARA PARA EL ARCHIVO ===
            echo "********************************************" >> "$OUTPUT_FILE"
            echo "ERRORES ENCONTRADOS EN: $log_file" >> "$OUTPUT_FILE"
            echo "********************************************" >> "$OUTPUT_FILE"
            
            # Añadir el contenido de los errores al archivo de salida
            echo "$ERROR_CONTENT" >> "$OUTPUT_FILE"
            echo "" >> "$OUTPUT_FILE"
        fi
    fi
done

echo "Proceso Terminado. Revisar el archivo $OUTPUT_FILE para los resultados."