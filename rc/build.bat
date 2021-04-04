@echo off
setlocal enabledelayedexpansion

where rc.exe >nul 2>nul

if NOT %ERRORLEVEL% == 0 (

	if exist "%programfiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" (

		for /F "tokens=* USEBACKQ" %%F in (`"%programfiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -property installationPath`) do (
			set INSTALLPATH=%%F
		)
		if exist "!INSTALLPATH!\Common7\Tools\VsDevCmd.bat" (
			call "!INSTALLPATH!\Common7\Tools\VsDevCmd.bat" -arch=x86 -app_platform=Desktop -no_logo
		)
	)
)

rc.exe /n pkg.rc > nul

link.exe /out:../pkg.dll /dll /machine:x86 /noentry pkg.res >nul
