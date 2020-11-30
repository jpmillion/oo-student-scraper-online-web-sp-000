require "pry"
require "open-uri"
require "nokogiri"

doc = Nokogiri::HTML(open("https://finance.yahoo.com/screener"))
screener_Table = doc.css("#predefined-screeners")
screener_names = screener_Table.css("a[href]").map {|e| e.text}
screener_links = screener_Table.css("a[href]").map {|e| e['href']}


growth = Nokogiri::HTML(open("https://finance.yahoo.com/" + screener_links[2]))
binding.pry
table = growth.css("#fin-scr-res-table tbody")
table_rows = table.css("tr")
symbols = table_rows.css("a").map {|e| e.text}
quotes = table_rows.css("a[href]").map {|e| e['href']}   

quote_info = Nokogiri::HTML(open("https://finance.yahoo.com/" + quotes[2]))
table = quote_info.css("#quote-summary table")
row_text = table.css("tr").map {|e| e.text}
profile = quote_info.css("#quote-nav li a").detect {|e| e.css("span").text == "Profile"}['href']
