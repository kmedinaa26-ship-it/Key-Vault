# Paso 7. Secreto, identidad administrada y referencia al Key Vault (videos 6 y 7)
. "$PSScriptRoot\00-variables.ps1"

# 1) Guardar la contraseña de PostgreSQL como secreto
$PASS = Read-Password "Contraseña de PostgreSQL para guardar en el Key Vault"
az keyvault secret set --vault-name $KV -n $SECRET --value $PASS -o none

# 2) Activar la identidad administrada asignada por el sistema
$PRINCIPAL = az webapp identity assign -g $RG -n $APP --query principalId -o tsv

# 3) Rol mínimo: solo leer secretos
$KVID = az keyvault show -n $KV --query id -o tsv
az role assignment create --role "Key Vault Secrets User" `
    --assignee-object-id $PRINCIPAL --assignee-principal-type ServicePrincipal --scope $KVID

# 4) DB_PASSWORD como referencia al secreto (sin versión, para tomar siempre la más reciente)
$ref = "@Microsoft.KeyVault(SecretUri=https://$KV.vault.azure.net/secrets/$SECRET/)"
@{ DB_PASSWORD = $ref } | ConvertTo-Json | Set-Content -Path "$PSScriptRoot\kvref.json" -Encoding ascii
az webapp config appsettings set -g $RG -n $APP --settings "@$PSScriptRoot\kvref.json" -o none
Remove-Item "$PSScriptRoot\kvref.json"

az webapp restart -g $RG -n $APP
