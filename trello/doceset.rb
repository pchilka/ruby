require './trello.rb'
require 'pp'

Trello.new("ZReu15ar").get_cards.each do |card|
	name      = card["name"]
	due       = card["due"]
	label_mpp = ""
	label_rfq = ""
	card["labels"].each do |label|
		if label["name"] == "MPP" then
			label_mpp = "MPP"
		elsif label["name"] == "RFQ" then
			label_rfq = "RFQ"
		end
	end
	puts "#{name}\t#{due}\t#{label_mpp}\t#{label_rfq}"
end
