# Paso 1. Grupo de recursos
. "$PSScriptRoot\00-variables.ps1"

az group create -n $RG -l $LOC --tags $TAGS
