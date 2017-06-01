
require 'rest-client'
require 'json'

TRELLO_KEY       = "71c20f4c575c32e1992e06801647400e"
TRELLO_TOKEN     = "dd360f6ce7448f8b2a5beb389433843a45d9c38ef39b8a1f6c6006b11ed1cd6e"
TRELLO_BOARD     = "5hEdN030"
TRELLO_API_URL   = "https://api.trello.com/1"

TRELLO_CARDS_URL = "#{TRELLO_API_URL}/boards/"          + \
	"#{TRELLO_BOARD}/cards?filter=all&key=#{TRELLO_KEY}" + \
	"&token=#{TRELLO_TOKEN}"

TRELLO_LISTS_URL = "#{TRELLO_API_URL}/boards/"          + \
	"#{TRELLO_BOARD}/lists?key=#{TRELLO_KEY}"            + \
	"&token=#{TRELLO_TOKEN}"


CARDS = JSON.parse RestClient.get TRELLO_CARDS_URL
LISTS = JSON.parse RestClient.get TRELLO_LISTS_URL

def get_list(card)
	LISTS.each do |list|
		return list["name"] if list["id"].eql? card["idList"]
	end
	return "List not found"
end

CARDS.each do |card|
	if not card["closed"]
		name   = card["name"]
		list   = get_list card
		puts "#{name},#{list}" if not list.eql? "Backlog"
	end
end
