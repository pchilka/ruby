
require 'rest-client'
require 'json'

TRELLO_KEY       = "71c20f4c575c32e1992e06801647400e"
TRELLO_TOKEN     = "dd360f6ce7448f8b2a5beb389433843a45d9c38ef39b8a1f6c6006b11ed1cd6e"
TRELLO_BOARD     = "bLRjUcgl"
TRELLO_API_URL   = "https://api.trello.com/1"

TRELLO_CARDS_URL = "#{TRELLO_API_URL}/boards/"          + \
	"#{TRELLO_BOARD}/cards?filter=all&key=#{TRELLO_KEY}" + \
	"&token=#{TRELLO_TOKEN}"

TRELLO_LISTS_URL = "#{TRELLO_API_URL}/boards/"          + \
	"#{TRELLO_BOARD}/lists?key=#{TRELLO_KEY}"            + \
	"&token=#{TRELLO_TOKEN}"


CARDS = JSON.parse RestClient.get TRELLO_CARDS_URL
LISTS = JSON.parse RestClient.get TRELLO_LISTS_URL

def get_job(card)
	card["labels"].each do |label|
		mo = /^Job::(.+)$/.match label["name"]
		return mo[1] unless mo.nil?
	end
	return "Job Not Recognized"
end


def get_source(card)
	card["labels"].each do |label|
		mo = /^Source::(.+)::(.+)$/.match label["name"]
		return mo[2] unless mo.nil?
	end
	return "Source Not Recognized"
end

def phone_screened?(card)
	card_id = card["shortLink"]
	actions = JSON.parse RestClient.get TRELLO_API_URL + "/cards/#{card_id}/actions?key=#{TRELLO_KEY}&token=#{TRELLO_TOKEN}"
	actions.each do |act|
		if act["type"].eql? "updateCard"
			return true if (act["data"]["listAfter"]["name"].eql? "Phone Screen") || \
								(act["data"]["listBefore"]["name"].eql? "Phone Screen")
		end
	end
	return false
end

def get_status(card)

	rejected_by_team   = false
	approved_by_client = false
	rejected_by_client = false
	onboarded          = false
	took_another_job   = false
	overcome_by_events = false

	card["labels"].each do |label|
		if label["name"].eql? "Status::Rejected By Team"
			rejected_by_team = true
		elsif label["name"].eql? "Status::Approved By Client"
			approved_by_client = true
		elsif label["name"].eql? "Status::Rejected By Client"
			rejected_by_client = true
		elsif label["name"].eql? "Status::Onboarded"
			onboarded = true
		elsif label["name"].eql? "Status::Took Another Job"
			took_another_job = true
		elsif label["name"].eql? "Status::Overcome By Events"
			overcome_by_events = true
		end
	end


	if rejected_by_team
		if phone_screened? card
			return "Rejected By Team After Phone Screen"
		else
			return "Rejected By Team Before Phone Screen"
		end
	elsif rejected_by_client
		return "Rejected By Client"
	elsif onboarded
		return "Onboarded"
	elsif took_another_job and approved_by_client
		return "Approved By Client Took Another Job"
	elsif took_another_job and (not approved_by_client)
		return "Approved By Team Took Another Job"
	elsif overcome_by_events and approved_by_client
		return "Approved By Client Overcome By Events"
	elsif overcome_by_events and (not approved_by_client)
		return "Approved By Team Overcome By Events"
	elsif approved_by_client
		return "Approved By Client"
	elsif overcome_by_events
		return "Overcome By Events"
	elsif not card["closed"]
		return "In Progress"
	else
		return "Dang it could not figure this!"
	end

end

def get_list(card)
	LISTS.each do |list|
		return list["name"] if list["id"].eql? card["idList"]
	end
	return "List not found"
end

CARDS.each do |card|
	name   = card["name"]
	job    = get_job card
	source = get_source card
	status = get_status card
	list   = get_list card
	puts "#{name},#{job},#{source},#{status},#{list}"
end
