cls
Write-Host ''
Write-Host '============================================================================'

# Renomeando o computador
$computerName = Read-Host -Prompt '01. Nome da estacao'
if ($computerName)
{
    # Renomeando a estacao
    #Write-Host ''
    #Write-Host -NoNewline '...Renomeando a estacao...'
    #Rename-Computer -NewName $computerName
    #Write-Host ' OK'

    # Criacao do usuario ihmlocal
    Write-Host ''
    $password = Read-Host '02. Senha do usuario ihmlocal'
    $password = ConvertTo-SecureString $password -AsPlainText -Force
    Write-Host ''
    Write-Host -NoNewline '...Criando usuario ihmlocal...'
    New-LocalUser -Name 'ihmlocal' -FullName 'ihmlocal' -Password $password -PasswordNeverExpires
    Write-Host ' OK'

    # Desativando hibernacao/suspensao
    Write-Host -NoNewline '...Desativando hibernacao/suspensao...'
    Powercfg /Change monitor-timeout-ac 0
    Powercfg /Change standby-timeout-ac 0
    Write-Host ' OK'

    # Renomeando estacao e ingressando no dominio
    Write-Host -NoNewline '...Ingressando no dominio ihm.local...'
    #add-computer -domainname "ihm.local"
    Add-Computer -DomainName ihm.local -NewName $computerName
    Write-Host ' OK'
}
else
{
    Write-Warning -Message 'Nome invalido para a estacao.'
}

Write-Host ''
Write-Host '============================================================================'
Write-Host 'Configuracao concluida. Reinicie a estação.'
Write-Host ''