$ErrorActionPreference = "Stop"

# Local Windows build helper for Artisan (one-folder dist).
# Preconditions:
# - Run from a PowerShell where `python` points to the environment with all deps installed.
# - Install pyinstaller: `python -m pip install pyinstaller pyinstaller-versionfile`
#
# Output: dist\artisan\artisan.exe

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $here

python -V

$pyinstaller = python -c "import importlib.util; print('1' if importlib.util.find_spec('PyInstaller') else '0')"
if ($pyinstaller.Trim() -ne "1") {
  Write-Error "PyInstaller is not installed. Run: python -m pip install pyinstaller pyinstaller-versionfile"
}

Write-Host "Running pyinstaller..."
pyinstaller --noconfirm --log-level=INFO artisan-win.spec

Write-Host "Done. Check dist\\artisan\\artisan.exe"

