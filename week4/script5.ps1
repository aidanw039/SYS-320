$a = Get-Content C:\xampp\apache\logs\*.log | Select-String 'error'
$a[-1..-5]