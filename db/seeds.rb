require "open-uri"

url = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"
doc = Nokogiri::HTML(open(url))
nodes = doc.css("tr")
nodes.shift
user = User.create(email: "#{('a'..'z').to_a.sample(10).join}@fakemail.com", password: "123", password_confirmation: "123", locale: "en")
deck = Deck.create(description: "Standart deck", user: user, standart: true)
puts "For login use this email: " + user.email + " and this password: 123"

nodes.each do |node|
  original_text = node.first_element_child.next_element.inner_text
  translated_text = node.last_element_child.previous_element.inner_text
  Card.create(original_text: original_text, translated_text: translated_text, user: user, deck: deck)
end
