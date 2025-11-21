# Obtiene la lista de registros de eventos disponibles.
$logs = Get-EventLog -List
$opcion = ""

# El bucle continúa mientras la opción no sea "0".
while ($opcion -ne "0") {
    Clear-Host
    
    Write-Host "=== REGISTROS DE EVENTOS ==="
    
    # Muestra el menú asignando un número a cada log.
    $num = 1
    $logs | ForEach-Object {
        Write-Host "$num. $($_.Log)"
        $num++
    }
    
    Write-Host "0. salir"
    
    # Pide la selección al usuario.
    $opcion = Read-Host "Elige un número"
    
    # Procesa la opción si no es "0".
    if ($opcion -ne "0") {
        # Calcula el índice (la lista es base 1, el array es base 0).
        $indice = [int]$opcion - 1
        
        # 1. Validación de índice y 2. Existencia del registro.
        if ($indice -ge 0 -and $indice -lt $logs.Count) {
            $logElegido = $logs[$indice].Log
            
            Write-Host "`nMostrando últimos 12 eventos de: $logElegido"
            
            # Intenta obtener los eventos usando Get-WinEvent (compatible con todos los logs).
            try {
                Get-WinEvent -LogName $logElegido -MaxEvents 12 -ErrorAction Stop
            }
            catch {
                Write-Host "Registro vacío o sin permisos." -ForegroundColor Red
            }
            
            Read-Host "Pulsa Enter para continuar..." | Out-Null
        }
        else {
            Write-Host "`nERROR: Opción no válida." -ForegroundColor Yellow
        }
    }
    
    Start-Sleep -Seconds 1
}

Write-Host "`nFin del programa"