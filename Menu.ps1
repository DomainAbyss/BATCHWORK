function Show-Menu {
    Clear-Host
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "     POWERSHELL SWISS ARMY     " -ForegroundColor White -BackgroundColor DarkCyan
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "1. Lihat Alamat IP"
    Write-Host "2. Cek Penggunaan RAM"
    Write-Host "3. Buka Control Panel"
    Write-Host "4. Keluar"
    Write-Host "-------------------------------"
}

do {
    Show-Menu
    $pilihan = Read-Host "Pilih opsi (1-4)"

    switch ($pilihan) {
        '1' { 
            Get-NetIPAddress | Where-Object AddressFamily -eq 'IPv4' | Select-Object InterfaceAlias, IPAddress | Out-String | Write-Host -ForegroundColor Yellow
            Pause 
        }
        '2' { 
            Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5 Name, @{Name='RAM(MB)';Expression={"{0:N2}" -f ($_.WorkingSet / 1MB)}} | Out-String | Write-Host -ForegroundColor Green
            Pause 
        }
        '3' { 
            control.exe 
        }
        '4' { 
            Write-Host "Sampai jumpa!" -ForegroundColor Magenta
            return 
        }
        Default { 
            Write-Host "Pilihan tidak tersedia!" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
} while ($true)
