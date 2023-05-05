do{
$erro = 'false'
	try{
# Baixa o winget
try{
	if(winget) {"Instalador de aplicativos já existente, prosseguindo"}
}
catch{
	try{
	# get latest download url
	$URL = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
	$URL = (Invoke-WebRequest -Uri $URL -UseBasicParsing).Content | ConvertFrom-Json |
			Select-Object -ExpandProperty "assets" |
			Where-Object "browser_download_url" -Match '.msixbundle' |
			Select-Object -ExpandProperty "browser_download_url"

	# download
	Invoke-WebRequest -Uri $URL -OutFile "Setup.msix" -UseBasicParsing

	# install
    	Start-Process -FilePath .\"Setup.msix"
    	do{
        Start-Sleep -Seconds 1
    	} while ((Get-Process "AppInstaller" -ErrorAction SilentlyContinue) -ne $null)

	# delete file
	Remove-Item "Setup.msix"
	
	echo 'Gerenciador de pacotes instalado'
	}
	catch {pause}
}

# Programas
winget install -e --id Apache.OpenOffice --accept-source-agreements --silent
winget install -e --id Microsoft.Teams --accept-source-agreements --silent
winget install -e --id Adobe.Acrobat.Reader.32-bit --accept-source-agreements --silent
winget install -e --id Oracle.JavaRuntimeEnvironment --accept-source-agreements --silent

# Programas do Ninite
winget install -e --id Mozilla.Firefox.ESR --accept-source-agreements --silent
winget install -e --id Microsoft.Edge --accept-source-agreements --silent
winget install -e --id 7zip.7zip --accept-source-agreements --silent
winget install -e --id Notepad++.Notepad++ --accept-source-agreements --silent
winget install -e --id CodecGuide.K-LiteCodecPack.Standard --accept-source-agreements --silent
#  winget install -e --id TeamViewer.TeamViewer --accept-source-agreements --silent
winget install -e --id Google.Chrome --accept-source-agreements --silent

	}catch{
	cls
	$erro = 'true'}
}while ($erro = 'true')
