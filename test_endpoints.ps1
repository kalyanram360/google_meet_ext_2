# Test all endpoints
Write-Host "`n====== Testing ClassBoost Endpoints ======`n" -ForegroundColor Cyan

Write-Host "[1/3] Testing Quiz Generation..." -ForegroundColor Yellow
try {
    $quizData = Invoke-WebRequest -UseBasicParsing -Method POST `
        -Uri "http://localhost:3000/api/generate-quiz" `
        -Headers @{'Content-Type'='application/json'} `
        -Body '{"topic":"science"}' | 
        Select-Object -ExpandProperty Content | ConvertFrom-Json
    Write-Host "   ✅ Quiz: $($quizData.quiz.mcq.Count) questions generated" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Quiz Failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n[2/3] Testing Flashcard Generation..." -ForegroundColor Yellow
try {
    $flashData = Invoke-WebRequest -UseBasicParsing `
        -Uri "http://localhost:3000/api/generateFlashcard?topic=science" |
        Select-Object -ExpandProperty Content | ConvertFrom-Json
    Write-Host "   ✅ Flashcard: Generated for '$($flashData.topic)'" -ForegroundColor Green
    Write-Host "      Q: $($flashData.flashcard.front.Substring(0, [Math]::Min(50, $flashData.flashcard.front.Length)))..." -ForegroundColor Gray
} catch {
    Write-Host "   ❌ Flashcard Failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n[3/3] Testing GIF Search..." -ForegroundColor Yellow
try {
    $gifData = Invoke-WebRequest -UseBasicParsing `
        -Uri "http://localhost:3000/api/searchGif?topic=science" |
        Select-Object -ExpandProperty Content | ConvertFrom-Json
    if ($gifData.ok) {
        Write-Host "   ✅ GIF: Found" -ForegroundColor Green
    } else {
        Write-Host "   ❌ GIF: $($gifData.error)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   ❌ GIF: API not enabled" -ForegroundColor Yellow
}

Write-Host "`n======================================`n" -ForegroundColor Cyan
