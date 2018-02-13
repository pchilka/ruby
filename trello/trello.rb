require 'rest-client'
require 'json'

TRELLO_KEY       = "71c20f4c575c32e1992e06801647400e"
TRELLO_TOKEN     = "dd360f6ce7448f8b2a5beb389433843a45d9c38ef39b8a1f6c6006b11ed1cd6e"
TRELLO_API_URL   = "https://api.trello.com/1"


class Trello
	attr_reader :cards
	attr_reader :lists
	def initialize(boardid)
		@cards_url = "#{TRELLO_API_URL}/boards/"          + \
			"#{boardid}/cards?filter=all&key=#{TRELLO_KEY}" + \
			"&token=#{TRELLO_TOKEN}"

		@lists_url = "#{TRELLO_API_URL}/boards/"          + \
			"#{boardid}/lists?key=#{TRELLO_KEY}"            + \
			"&token=#{TRELLO_TOKEN}"
		@cards = JSON.parse RestClient.get @cards_url
		@lists = JSON.parse RestClient.get @lists_url
	end
end
