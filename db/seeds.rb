require "open-uri"

url = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"
@doc = Nokogiri::HTML(open(url))

def pull_date(fucking_variable)
  original_text = @doc.at_css("tr.row#{fucking_variable}:nth-child(#{@i}) > td:nth-child(2)").text
  translated_text = @doc.at_css("tr.row#{fucking_variable}:nth-child(#{@i}) > td:nth-child(3)").text
  Card.create(original_text: original_text, translated_text: translated_text)
end

def stupid_check
  @doc.at_css("tr.rowA:nth-child(#{@i}) > td:nth-child(2)").nil?
end

for @i in 2..6
  if stupid_check
    pull_date ("B")
  else
    pull_date ("A")
  end
end
