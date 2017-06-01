
require 'rest-client'
require 'json'

count = 0
key   = "71c20f4c575c32e1992e06801647400e"
token = "dd360f6ce7448f8b2a5beb389433843a45d9c38ef39b8a1f6c6006b11ed1cd6e"
board = "bLRjUcgl"
JAVA_DEVELOPER = "Java Developer"
hash  = {}

resp  = RestClient.get "https://api.trello.com/1/boards/#{board}/lists?key=#{key}&token=#{token}"
json  = JSON.parse resp
puts JSON.pretty_generate json
