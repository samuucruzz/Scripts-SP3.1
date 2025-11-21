# 1. Menú de opciones
Write-Host "=== CONSULTA DE REGISTROS DEL SISTEMA ==="
Write-Host "1. Ver listado de eventos del sistema"
Write-Host "2. Ver errores registrados en el último mes"
Write-Host "3. Ver advertencias de aplicaciones (última semana)"
Write-Host "============================================="

# 2. Solicitar opción al usuario
$seleccion = Read-Host "Introduce el número de opción"

# 3. Procesar la opción elegida
if ($seleccion -eq "1") {
    # Mostrar eventos del sistema
    Write-Host "`nObteniendo eventos del registro System..."
    Get-EventLog -LogName System -Newest 15
    Write-Host "`nTotal de eventos mostrados: 15"
}
elseif ($seleccion -eq "2") {
    # Mostrar errores del último mes
    Write-Host "`nBuscando errores en el último mes..."
    $fechaInicio = (Get-Date).AddMonths(-1)
    Write-Host "Desde: $fechaInicio"
    Get-EventLog -LogName System -EntryType Error -After $fechaInicio
}
elseif ($seleccion -eq "3") {
    # Mostrar warnings de la semana
    Write-Host "`nBuscando advertencias de la última semana..."
    $inicioDeSemana = (Get-Date).AddDays(-7)
    Write-Host "Desde: $inicioDeSemana"
    Get-EventLog -LogName Application -EntryType Warning -After $inicioDeSemana
}
else {
    # Opción no válida
    Write-Host "`n[ERROR] La opción '$seleccion' no es válida."
    Write-Host "Por favor, selecciona 1, 2 o 3."
}