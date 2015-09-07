require "open-uri"

url = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"
doc = Nokogiri::HTML(open(url))
nodes = doc.css("tr")
nodes.shift
user = User.first

nodes.each do |node|
  original_text = node.first_element_child.next_element.inner_text
  translated_text = node.last_element_child.previous_element.inner_text
  Card.create(original_text: original_text, translated_text: translated_text, user_id: user.id)
end
