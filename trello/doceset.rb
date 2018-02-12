
require 'rest-client'
require 'json'
require 'pp'
require 'time'

TRELLO_KEY       = "71c20f4c575c32e1992e06801647400e"
TRELLO_TOKEN     = "dd360f6ce7448f8b2a5beb389433843a45d9c38ef39b8a1f6c6006b11ed1cd6e"
TRELLO_BOARD     = "ZReu15ar"
TRELLO_API_URL   = "https://api.trello.com/1"

TRELLO_CARDS_URL = "#{TRELLO_API_URL}/boards/"          + \
	"#{TRELLO_BOARD}/cards?filter=all&key=#{TRELLO_KEY}" + \
	"&token=#{TRELLO_TOKEN}"

TRELLO_LISTS_URL = "#{TRELLO_API_URL}/boards/"          + \
	"#{TRELLO_BOARD}/lists?key=#{TRELLO_KEY}"            + \
	"&token=#{TRELLO_TOKEN}"


CARDS = JSON.parse RestClient.get TRELLO_CARDS_URL
LISTS = JSON.parse RestClient.get TRELLO_LISTS_URL

CARDS.each do |card|
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
