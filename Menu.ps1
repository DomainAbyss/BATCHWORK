# --- KONFIGURASI AWAL ---
$ErrorActionPreference = "SilentlyContinue"

function Show-Menu {
    Clear-Host
    Write-Host "===============================================" -ForegroundColor Cyan
    Write-Host "         POWERSHELL ADMIN TOOLBOX v1.1         " -ForegroundColor White -BackgroundColor DarkBlue
    Write-Host "===============================================" -ForegroundColor Cyan
    Write-Host " [1] Cek Koneksi & Alamat IP" 
    Write-Host " [2] Bersihkan File Temp (Safe Clean)" 
    Write-Host " [3] Cek Penggunaan RAM (Top 5)" 
    Write-Host " [4] Tampilkan Info OS & Hardware" 
    Write-Host " [5] Keluar" -ForegroundColor Red
    Write-Host "-----------------------------------------------" -ForegroundColor Cyan
}

do {
    Show-Menu
    $pilihan = Read-Host "Pilih opsi [1-5]"

    switch ($pilihan) {
        '1' {
            Write-Host "`n[ Mengambil Informasi Jaringan ]" -ForegroundColor Yellow
            # Contoh loading sederhana dengan titik-titik
            foreach($i in 1..3) { Write-Host "." -NoNewline; Start-Sleep -Milliseconds 300 }
            Write-Host " Done!`n" -ForegroundColor Green
            
            Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4' -and $_.InterfaceAlias -notlike "*Loopback*"} | `
            Select-Object InterfaceAlias, IPAddress | Out-String | Write-Host
            pause
        }
        
        '2' {
            Write-Host "`n[ Memulai Pembersihan ]" -ForegroundColor Yellow
            
            # --- ANIMASI LOADING / PROGRESS BAR ---
            $folders = @("$env:TEMP", "C:\Windows\Temp")
            for ($i = 1; $i -le 100; $i += 5) {
                Write-Progress -Activity "Sedang Menghapus Sampah Sistem" -Status "$i% Selesai" -PercentComplete $i
                Start-Sleep -Milliseconds 50 # Memberikan efek visual loading
            }

            foreach ($path in $folders) {
                Get-ChildItem -Path "$path\*" -Recurse | Remove-Item -Force -Recurse
            }
            
            Write-Host "Berhasil: Folder Temp telah dibersihkan!" -ForegroundColor Green
            pause
        }

        '3' {
            # Loading gaya spinner/putar
            $spinner = "|", "/", "-", "\"
            Write-Host "`nMemindai RAM " -NoNewline
            foreach($i in 1..10) {
                Write-Host "`b$($spinner[$i % 4])" -NoNewline
                Start-Sleep -Milliseconds 100
            }
            Write-Host "`b Selesai!`n" -ForegroundColor Green

            Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5 `
            Name, @{Name='RAM(MB)';Expression={"{0:N2}" -f ($_.WorkingSet / 1MB)}} | Out-String | Write-Host
            pause
        }

        '4' {
            Write-Progress -Activity "Mengambil Data Hardware" -Status "Mohon tunggu..." -PercentComplete 50
            Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, CsProcessors | Out-String | Write-Host
            Write-Progress -Activity "Mengambil Data Hardware" -Completed
            pause
        }

        '5' {
            Write-Host "`nKeluar... Sampai jumpa, Rizky!" -ForegroundColor Magenta
            exit
        }

        Default {
            Write-Host "`nPilihan tidak valid!" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
} while ($true)
