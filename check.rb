require 'rest-client'

base = "https://maps.googleapis.com/maps/api/directions/json"
origin="1111+Waukegan+Rd+Northbrook+IL"
destination="600+West+Chicago+Chicago+IL"
key="AIzaSyBhkyrAaG_hkuK1eUfK7K7ttcFXUrFa95c"

url = "#{base}origin=2223+Peachtree+Ln+Northbrook+IL"

begin 
  puts "==== starting"

  result = RestClient.get(base, {params: {origin: origin, destination: destination, key: key}})
  puts "==== success"
  puts result
rescue RestClient::ExceptionWithResponse => e
  puts "==== failed"
  puts e
  puts e.response
end   