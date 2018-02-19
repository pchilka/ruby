$LOAD_PATH.unshift('.')

require 'trello'
require 'pp'

Trello.new("ZReu15ar").cards.each do |card|
	name      = card["name"]
	due       = card["due"][0,10]
	label_mpp = ""
	label_rfq = ""
	card["labels"].each do |label|
		if label["name"] == "MPP" then
			label_mpp = "MPP"
		elsif label["name"] == "RFQ" then
			label_rfq = "RFQ"
		end
	end
	puts "#{name}\t#{due}\t#{label_mpp}\t#{label_rfq}" if not card["closed"]
end
