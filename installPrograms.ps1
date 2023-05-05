cls
echo '============================================================================'

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


# Java 32 bit
Invoke-WebRequest -UseBasicParsing -Uri "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=248240_ce59cff5c23f4e2eaf4e778a117d4c5b" -OutFile "../java32Bit.exe"
Start-Process -FilePath "..\java32Bit.exe"
# Tentar remover o javatemp.exe

# Remove o Office
winget uninstall -h -e --id Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe
try {
	Start-Process powershell.exe -ArgumentList "winget uninstall -h -e --id 'O365HomePremRetail - pt-br'"
}
catch {pause}

# NetExtender
echo "201.48.224.194:4433"
Set-Clipboard "201.48.224.194:4433 LocalDomain"
echo "LocalDomain"
winget install -i --id "SonicWALL.NetExtender" --accept-source-agreements