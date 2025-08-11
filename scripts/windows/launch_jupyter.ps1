Param(
  [string]$EnvName = "imt-211"
)
$ErrorActionPreference = "Stop"

# Asegurar conda en PATH
$conda = Get-Command conda -ErrorAction SilentlyContinue
if (-not $conda) {
  $env:Path = "$env:USERPROFILE\Miniconda3;$env:USERPROFILE\Miniconda3\condabin;$env:Path"
}

# Activar y lanzar JupyterLab en el navegador predeterminado
cmd /c "conda activate %EnvName% && jupyter lab"