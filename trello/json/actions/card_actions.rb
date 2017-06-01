
require 'rest-client'
require 'json'

count = 0
key   = "71c20f4c575c32e1992e06801647400e"
token = "dd360f6ce7448f8b2a5beb389433843a45d9c38ef39b8a1f6c6006b11ed1cd6e"
board = "bLRjUcgl"
card  = "EwRjqwBw"
card  = "0nMpBYCy"
JAVA_DEVELOPER = "Java Developer"
hash  = {}

resp    = RestClient.get "https://api.trello.com/1/boards/#{board}/cards?filter=all&key=#{key}&token=#{token}"
cards   = JSON.parse resp

def phone_screened?(actions)
	actions.each do |act|
		if act["type"].eql? "updateCard"
			return true if (act["data"]["listAfter"]["name"].eql? "Phone Screen") || \
								(act["data"]["listBefore"]["name"].eql? "Phone Screen")
		end
	end
	return false
end

cards.each do |card|
	card_id = card["shortLink"]
	resp    = RestClient.get "https://api.trello.com/1/cards/#{card_id}/actions?key=#{key}&token=#{token}"
	actions = JSON.parse resp
	puts "phone screened #{card_id} => " + card["name"] if phone_screened? actions
end

