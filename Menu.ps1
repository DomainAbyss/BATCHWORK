# --- KONFIGURASI AWAL ---
$ErrorActionPreference = "SilentlyContinue"

function Show-Menu {
    Clear-Host
    Write-Host "===============================================" -ForegroundColor Cyan
    Write-Host "         POWERSHELL ADMIN TOOLBOX v1.0         " -ForegroundColor White -BackgroundColor DarkBlue
    Write-Host "===============================================" -ForegroundColor Cyan
    Write-Host " [1] Cek Koneksi & Alamat IP" -ForegroundColor White
    Write-Host " [2] Bersihkan File Temp (Safe Clean)" -ForegroundColor White
    Write-Host " [3] Cek Penggunaan RAM (Top 5)" -ForegroundColor White
    Write-Host " [4] Tampilkan Info OS & Hardware" -ForegroundColor White
    Write-Host " [5] Keluar" -ForegroundColor Red
    Write-Host "-----------------------------------------------" -ForegroundColor Cyan
}

# --- LOOP MENU ---
do {
    Show-Menu
    $pilihan = Read-Host "Pilih opsi [1-5]"

    switch ($pilihan) {
        '1' {
            Write-Host "`n[ Mengambil Informasi Jaringan ]" -ForegroundColor Yellow
            Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4' -and $_.InterfaceAlias -notlike "*Loopback*"} | `
            Select-Object InterfaceAlias, IPAddress, PrefixOrigin | Out-String | Write-Host
            pause
        }
        
        '2' {
            Write-Host "`n[ Membersihkan Folder Temp... ]" -ForegroundColor Yellow
            $tempPaths = @("$env:TEMP\*", "C:\Windows\Temp\*")
            $before = (Get-ChildItem $env:TEMP -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
            
            foreach ($path in $tempPaths) {
                Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
            }
            
            $after = (Get-ChildItem $env:TEMP -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
            $saved = [math]::Round($before - $after, 2)
            
            Write-Host "Selesai! Anda menghemat sekitar $saved MB." -ForegroundColor Green
            pause
        }

        '3' {
            Write-Host "`n[ Top 5 Aplikasi Boros RAM ]" -ForegroundColor Yellow
            Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5 `
            Name, @{Name='RAM_Usage(MB)';Expression={"{0:N2}" -f ($_.WorkingSet / 1MB)}} | Out-String | Write-Host
            pause
        }

        '4' {
            Write-Host "`n[ Informasi Sistem ]" -ForegroundColor Yellow
            Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, CsProcessors | Out-String | Write-Host
            pause
        }

        '5' {
            Write-Host "`nKeluar dari program... Sampai jumpa, Rizky!" -ForegroundColor Magentat
            Start-Sleep -Seconds 1
            exit
        }

        Default {
            Write-Host "`nPilihan tidak valid! Silakan masukkan angka 1-5." -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
} while ($true)
