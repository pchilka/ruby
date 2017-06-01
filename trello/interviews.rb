
require 'rest-client'
require 'json'

TRELLO_KEY       = "71c20f4c575c32e1992e06801647400e"
TRELLO_TOKEN     = "dd360f6ce7448f8b2a5beb389433843a45d9c38ef39b8a1f6c6006b11ed1cd6e"
TRELLO_BOARD     = "GYTz4xK7"
TRELLO_API_URL   = "https://api.trello.com/1"

TRELLO_CARDS_URL = "#{TRELLO_API_URL}/boards/"          + \
	"#{TRELLO_BOARD}/cards?filter=all&key=#{TRELLO_KEY}" + \
	"&token=#{TRELLO_TOKEN}"

CARDS = JSON.parse RestClient.get TRELLO_CARDS_URL


def get_interview_labels(card)
	name = card["name"]
	card["labels"].each do |label|
		mo = /^Interviewer::(.+)::(.+)$/.match label["name"]
		puts "#{name},#{mo[1]},#{mo[2]}\n" unless mo.nil?
	end
end

CARDS.each {|card| get_interview_labels(card)}
