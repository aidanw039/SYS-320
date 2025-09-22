clear
$scraped_page = Invoke-WebRequest -TimeoutSec 5 http://10.0.17.43/ToBeScraped.html

$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | select outerText
$h2s