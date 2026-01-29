# Start All Services Script for Google Meet Extension
# This script starts all required services in separate PowerShell windows

Write-Host "Starting all services for Google Meet Extension..." -ForegroundColor Green

# Get the current directory
$rootDir = $PSScriptRoot
if (-not $rootDir) {
    $rootDir = Get-Location
}

Write-Host "`nRoot directory: $rootDir" -ForegroundColor Cyan

# 1. Start Node.js Server (port 3000)
Write-Host "`n[1/3] Starting Node.js Server (port 3000)..." -ForegroundColor Yellow
$serverPath = Join-Path $rootDir "server"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$serverPath'; Write-Host 'Node.js Server Starting on port 3000...' -ForegroundColor Green; npm start"

# 2. Start FastAPI Quiz Generator (port 9000)
Write-Host "[2/3] Starting FastAPI Quiz Generator (port 9000)..." -ForegroundColor Yellow
$quizPath = Join-Path $rootDir "quiz_generator_2"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$quizPath'; Write-Host 'FastAPI Quiz Generator Starting on port 9000...' -ForegroundColor Green; .\.venv\Scripts\Activate.ps1; uvicorn api_server:app --host 0.0.0.0 --port 9000"

# 3. Start Django Backend (port 8000)
Write-Host "[3/3] Starting Django Backend (port 8000)..." -ForegroundColor Yellow
$djangoPath = Join-Path $rootDir "final_SyncSolve-fe39ef375cc20aac6fb95dcfbfae2da8452cd99e"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$djangoPath'; Write-Host 'Django Backend Starting on port 8000...' -ForegroundColor Green; .\.venv\Scripts\Activate.ps1; python manage.py runserver"

Write-Host "`n✅ All services are starting in separate windows!" -ForegroundColor Green
Write-Host "`nServices:" -ForegroundColor Cyan
Write-Host "  • Node.js Server:      http://localhost:3000" -ForegroundColor White
Write-Host "  • FastAPI Quiz Gen:    http://localhost:9000" -ForegroundColor White
Write-Host "  • Django Backend:      http://localhost:8000" -ForegroundColor White

Write-Host "`nWait for all services to start, then load the extension in Chrome." -ForegroundColor Yellow
Write-Host "Extension location: $rootDir\Extension" -ForegroundColor Cyan
Write-Host "`nTo stop: Close each PowerShell window individually." -ForegroundColor Yellow
