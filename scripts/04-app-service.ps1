# Paso 4. Plan de App Service y App Service (video 3)
. "$PSScriptRoot\00-variables.ps1"

az appservice plan create -g $RG -n $ASP -l $LOC --is-linux --sku F1 --tags $TAGS

# Revisa el nombre exacto del runtime disponible con:
#   az webapp list-runtimes --os linux --query "[?contains(@, 'JAVA')]"
az webapp create -g $RG -p $ASP -n $APP --runtime "JAVA:25-java25" --https-only true --tags $TAGS
