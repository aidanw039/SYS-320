clear
$scraped_page = Invoke-WebRequest -TimeoutSec 5 http://10.0.17.43/ToBeScraped.html

$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | where {
$_.getAttributeNode("class").Value -ilike "div-1"} | select innerText
$divs1