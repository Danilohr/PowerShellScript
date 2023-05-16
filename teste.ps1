cls
echo '============================================================================'

# Baixa o winget
try{
	if(winget) {"Instalador de aplicativos ja existente, prosseguindo"}
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
	catch {
		echo 'Verifique a conexão com a internet e tente novamente' 
		pause}
}


$programs = 
    'Apache.OpenOffice',
    #'Microsoft.Teams',
    'Adobe.Acrobat.Reader.32-bit',
	'Oracle.JavaRuntimeEnvironment',
	'Mozilla.Firefox.ESR',
	'Microsoft.Edge',
	'7zip.7zip',
	'Notepad++.Notepad++',
	'CodecGuide.K-LiteCodecPack.Standard',
	#'TeamViewer.TeamViewer',
	'Google.Chrome'

for($i = 0 ; $i -lt $programs.count ; $i++){
	$nome = $($programs[$i].split('.')[1])
	echo "- $($nome):"
	
	for($erro = 0 ; $erro -lt 3 ;){
		winget install -h -e --id $programs[$i] --accept-source-agreements --ignore-checksum
		$result = winget list -e --id $programs[$i]
		
		if($result -like "Nenhum pacote instalado foi encontrado"){
			echo "Tentando instalar novamente"
		}
		else {
			$erro = 3
		}
		$erro++
	}
}


# Java 32 bit
$string = winget list 'Java'
$count = (Select-String -InputObject $string -Pattern 'Java 8 Update *' -AllMatches).Matches.Count
if($count -le 1){
	Invoke-WebRequest -UseBasicParsing -Uri "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=248240_ce59cff5c23f4e2eaf4e778a117d4c5b" -OutFile "../java32Bit.exe"
	Start-Process -FilePath "..\java32Bit.exe"
	echo 'instalador do java deve ter aberto'
	# Tentar remover o javatemp.exe
}

# Remove o Office
winget uninstall -h -e --id Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe
try {
	#winget uninstall -h -e --id 'O365HomePremRetail - pt-br' --accept-source-agreements
	Start-Process powershell.exe -ArgumentList "winget uninstall -h -e --id 'O365HomePremRetail - pt-br' --accept-source-agreements"
}
catch {pause}

# Ninite e Teams
Start-Process -FilePath '\\ihm.local\arquivos\SUPORTE TECNICO\Formatacao\Ninite NET.exe'
Start-Process -FilePath '\\ihm.local\arquivos\SUPORTE TECNICO\Formatacao\TeamsSetup_c_w_.exe'

# NetExtender
echo "201.48.224.194:4433"
Set-Clipboard "201.48.224.194:4433 LocalDomain"
echo "LocalDomain"
winget install -i --id 'SonicWALL.NetExtender'