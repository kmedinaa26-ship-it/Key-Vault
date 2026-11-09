# Paso 6. Compilación y despliegue del JAR (video 5)
# Uso: .\06-compilar-desplegar.ps1 -Proyecto C:\ruta\school-management-api
param([Parameter(Mandatory = $true)][string]$Proyecto)
. "$PSScriptRoot\00-variables.ps1"

Push-Location $Proyecto
mvn clean install -DskipTests
$JAR = Get-ChildItem target\*.jar | Where-Object { $_.Name -notlike "*plain*" } | Select-Object -First 1
az webapp deploy -g $RG -n $APP --src-path $JAR.FullName --type jar
Pop-Location

Write-Host "Swagger: https://$APP.azurewebsites.net/swagger-ui/index.html"
