param(
    [Parameter(Mandatory=$true)]
    [datetime]$FechaInicio,
    [Parameter(Mandatory=$true)]
    [datetime]$FechaFin
)

# ID 4624: Significa "Se inició sesión correctamente en una cuenta".
# Utilizamos un filtro hash para máxima eficiencia y rapidez en la búsqueda.
$Filtro = @{
    LogName   = 'Security'
    Id        = 4624
    StartTime = $FechaInicio
    EndTime   = $FechaFin
}

Write-Host "--- Inicios de Sesión entre $($FechaInicio.ToShortDateString()) y $($FechaFin.ToShortDateString()) ---"

# Obtener los eventos, seleccionar solo la información relevante y filtrar el usuario SYSTEM.
$Eventos = Get-WinEvent -FilterHashtable $Filtro | Select-Object -First 100

if ($Eventos.Count -eq 0) {
    Write-Warning "No se encontraron inicios de sesión para el rango de fechas especificado."
}
else {
    $Eventos | ForEach-Object {
        # Extraer el nombre de usuario del XML del evento.
        $Usuario = $_.Properties[5].Value
        
        # Excluir el usuario SYSTEM, que no es un inicio de sesión interactivo.
        if ($Usuario -ne 'SYSTEM') {
            [PSCustomObject]@{
                Dia  = $_.TimeCreated.ToString("dd/MM/yyyy")
                Hora = $_.TimeCreated.ToString("HH:mm:ss")
                Usuario = $Usuario
            }
        }
    } | Format-Table -AutoSize
}