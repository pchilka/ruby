require 'rest-client'
require 'json'
require 'pp'

WMATA_KEY       = "8570cea1dbde47c9a12484beb9bd126d" 
WMATA_API_URL   = "https://api.wmata.com/StationPrediction.svc/json/GetPrediction/" 
STATION         = "K08"

request  = WMATA_API_URL + STATION
headers  = {"api_key" => WMATA_KEY}
response = JSON.parse RestClient.get(request, headers)
pp response
