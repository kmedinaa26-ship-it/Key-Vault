# Paso 5. Variables de entorno del App Service (video 4)
. "$PSScriptRoot\00-variables.ps1"

# Se pasan en un archivo JSON porque en Windows az usa cmd.exe, que interpreta
# caracteres como ( ) y ; dentro de los valores.
$settings = @{
    DB_HOST                = "$PG.postgres.database.azure.com"
    DB_PORT                = "5432"
    DB_NAME                = $DB
    DB_USERNAME            = $ADMIN
    SPRING_PROFILES_ACTIVE = "azure"
    PORT                   = "8080"
}
$settings | ConvertTo-Json | Set-Content -Path "$PSScriptRoot\settings.json" -Encoding ascii
az webapp config appsettings set -g $RG -n $APP --settings "@$PSScriptRoot\settings.json" -o none
Remove-Item "$PSScriptRoot\settings.json"
