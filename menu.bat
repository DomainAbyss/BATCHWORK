@echo off
title Script Menu Keren v1.0
cls

:menu
echo ===========================================
echo           TOOLBOX CMD INTERAKTIF
echo ===========================================
echo  [1] Cek Statistik Jaringan
echo  [2] Bersihkan File Sampah (Temp)
echo  [3] Tampilkan Informasi OS
echo  [4] Keluar
echo ===========================================
set /p pilih="Pilih nomor (1-4): "

if "%pilih%"=="1" goto network
if "%pilih%"=="2" goto clean
if "%pilih%"=="3" goto info
if "%pilih%"=="4" exit
echo.
echo Pilihan salah, coba lagi!
pause
goto menu

:network
cls
echo Mengambil data jaringan...
netstat -an | findstr "ESTABLISHED"
pause
goto menu

:clean
cls
echo Sedang membersihkan folder Temp...
del /q /f /s %temp%\*
echo Selesai!
pause
goto menu

:info
cls
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
pause
goto menu
