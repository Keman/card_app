require "open-uri"

url = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"
@doc = Nokogiri::HTML(open(url))

def pull_data(selector, i)
  original_text = @doc.at_css("tr.row#{selector}:nth-child(#{i}) > td:nth-child(2)").text
  translated_text = @doc.at_css("tr.row#{selector}:nth-child(#{i}) > td:nth-child(3)").text
  Card.create(original_text: original_text, translated_text: translated_text)
end

(2..51).each do |i|
  if @doc.at_css("tr.rowA:nth-child(#{i}) > td:nth-child(2)").nil?
    pull_data("B", i)
  else
    pull_data("A", i)
  end
end
