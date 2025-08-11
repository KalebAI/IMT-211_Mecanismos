Param(
  [string]$EnvName = "imt-211"
)

$ErrorActionPreference = "Stop"

function Write-Section($msg) {
  Write-Host "=== $msg ==="
}

# Detect conda
$conda = Get-Command conda -ErrorAction SilentlyContinue
if (-not $conda) {
  Write-Section "Conda no encontrado. Instalando Miniconda (usuario)"
  $installer = "$env:TEMP\Miniconda3-latest-Windows-x86_64.exe"
  $url = "https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe"
  Invoke-WebRequest -Uri $url -OutFile $installer
  Start-Process -FilePath $installer -ArgumentList "/InstallationType=JustMe /AddToPath=1 /S /D=$env:USERPROFILE\Miniconda3" -Wait
  # Cargar conda
  $condaBat = Join-Path $env:USERPROFILE "Miniconda3\condabin\conda.bat"
  if (-not (Test-Path $condaBat)) {
    throw "No se pudo encontrar conda.bat después de instalar Miniconda."
  }
  $env:Path = "$env:USERPROFILE\Miniconda3;$env:USERPROFILE\Miniconda3\condabin;$env:Path"
} else {
  Write-Section "Conda detectado: $($conda.Source)"
}

# Asegurar conda-forge con prioridad flexible
conda config --add channels conda-forge | Out-Null
conda config --add channels defaults | Out-Null
conda config --set channel_priority flexible | Out-Null

# Crear/actualizar entorno
if (conda env list | Select-String -Pattern "^\s*$EnvName\s") {
  Write-Section "Actualizando entorno '$EnvName'"
  conda env update -n $EnvName -f environment.yml --prune
} else {
  Write-Section "Creando entorno '$EnvName'"
  conda env create -f environment.yml
}

Write-Section "Activando entorno"
# Usar conda.bat para activar en PowerShell
& conda activate $EnvName
if ($LASTEXITCODE -ne 0) {
  Write-Section "Activación con 'conda activate' falló, se intentará conconda.bat"
  & "$env:USERPROFILE\Miniconda3\condabin\conda.bat" activate $EnvName
}

Write-Section "Listo. Puedes iniciar Jupyter con 'scripts\\windows\\launch_jupyter.ps1'"