# Variables compartidas por todos los scripts.
# Uso: se cargan automáticamente con ". .\00-variables.ps1" al inicio de cada script.

$RG    = "rg-utvt-integradora-dev-mxc-001"
$LOC   = "mexicocentral"
$TAGS  = @("cost_center=utvt", "environment=dev", "managed_by=cli", "owner=equipo-integradora")

$PG    = "psql-utvt-integradora-dev-mxc-km001"
$DB    = "school_management"
$ADMIN = "adminpgdev"

$KV     = "kv-utvt-int-dev-mxc-km1"
$SECRET = "db-password"

$ASP   = "asp-utvt-integradora-dev-mxc-001"
$APP   = "app-utvt-integradora-api-dev-mxc-km001"

function Read-Password([string]$prompt) {
    $sec = Read-Host $prompt -AsSecureString
    return [Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
}
