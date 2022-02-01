require 'rubygems'
require 'rest_client'

url = 'http://api.twitter.com/1/trends.json'

response = RestClient.get(url)

puts response.body
