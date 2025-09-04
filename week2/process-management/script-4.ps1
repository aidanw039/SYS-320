$chrome = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

if ($chrome) {
   kill $chrome
} else {
    Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "champlain.edu"
}