# Paso 8. Pruebas de la API
. "$PSScriptRoot\00-variables.ps1"

$BASE = "https://$APP.azurewebsites.net/api/v1/students"

$body = @{
    studentNumber   = "222310001"
    firstName       = "Key"
    paternalSurname = "Medina"
    maternalSurname = "Lopez"
    email           = "key@utvt.edu.mx"
    dateOfBirth     = "2003-05-10"
} | ConvertTo-Json

# POST -> 201 Created
$nuevo = Invoke-RestMethod -Method Post -Uri $BASE -ContentType "application/json" -Body $body
$nuevo

# GET -> 200 OK
Invoke-RestMethod -Uri "$BASE/$($nuevo.id)"

# Verificación en la base de datos (DataGrip / pgAdmin):
#   SELECT * FROM students;
