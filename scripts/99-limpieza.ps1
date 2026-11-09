# Eliminar todos los recursos al terminar para no consumir créditos
. "$PSScriptRoot\00-variables.ps1"

az group delete -n $RG --yes --no-wait
