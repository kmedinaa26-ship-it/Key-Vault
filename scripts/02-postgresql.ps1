# Paso 2. PostgreSQL Flexible Server, base de datos y firewall (video 1)
. "$PSScriptRoot\00-variables.ps1"

$PASS = Read-Password "Contraseña del administrador de PostgreSQL"

# Servidor Burstable B1ms. --public-access 0.0.0.0 habilita el acceso público
# y crea la regla que permite el tráfico desde servicios de Azure (App Service).
az postgres flexible-server create -g $RG -n $PG -l $LOC `
    --tier Burstable --sku-name Standard_B1ms --storage-size 32 --version 16 `
    --admin-user $ADMIN --admin-password $PASS `
    --public-access 0.0.0.0 --tags $TAGS --yes

az postgres flexible-server db create -g $RG -s $PG -d $DB

# Regla para la IP pública del equipo local (para conectarse con DataGrip / pgAdmin).
# Si la IP cambia, vuelve a ejecutar estas dos líneas con otro nombre de regla.
$IP = (Invoke-RestMethod https://ifconfig.me/ip).Trim()
az postgres flexible-server firewall-rule create -g $RG --server-name $PG `
    --name MiIPCasa --start-ip-address $IP --end-ip-address $IP

az postgres flexible-server show -g $RG -n $PG --query "{estado:state, host:fullyQualifiedDomainName, version:version}" -o table
