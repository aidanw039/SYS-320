clear
$scraped_page = Invoke-WebRequest -TimeoutSec 5 http://10.0.17.43/ToBeScraped.html
$scraped_page.Links | select href,outerText