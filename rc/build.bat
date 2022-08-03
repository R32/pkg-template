@echo off
setlocal enabledelayedexpansion

set ARCH=x86
IF "%1"=="x64" (
	set ARCH=x64
)
@echo %ARCH%

where rc.exe >nul 2>nul

if NOT %ERRORLEVEL% == 0 (

	if exist "%programfiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" (

		for /F "tokens=* USEBACKQ" %%F in (`"%programfiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -property installationPath`) do (
			set INSTALLPATH=%%F
		)
		if exist "!INSTALLPATH!\Common7\Tools\VsDevCmd.bat" (
			call "!INSTALLPATH!\Common7\Tools\VsDevCmd.bat" -arch=%ARCH% -app_platform=Desktop -no_logo
		)
	)
)

rc.exe /n pkg.rc >nul

link.exe /out:../pkg.dll /dll /machine:%ARCH% /noentry pkg.res >nul
