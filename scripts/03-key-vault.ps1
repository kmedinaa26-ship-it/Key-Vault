# Paso 3. Key Vault con modelo de permisos RBAC (video 2)
. "$PSScriptRoot\00-variables.ps1"

az keyvault create -g $RG -n $KV -l $LOC --enable-rbac-authorization true --tags $TAGS

# Con RBAC, ser propietario de la suscripción no da acceso a los secretos:
# hay que asignarse el rol Key Vault Administrator sobre el Key Vault.
$ME   = az ad signed-in-user show --query id -o tsv
$KVID = az keyvault show -n $KV --query id -o tsv
az role assignment create --role "Key Vault Administrator" `
    --assignee-object-id $ME --assignee-principal-type User --scope $KVID
