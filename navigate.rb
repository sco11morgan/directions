require "json"
require "rest-client"

class Navigate
  # attr_reader :origin, :destination, :key, :base

  # def initialize
 def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @origin="1111+Waukegan+Rd+Northbrook+IL"
    @destination="600+West+Chicago+Chicago+IL"
    @key = "api-key"
    @base = "https://maps.googleapis.com/maps/api/directions/json"
  end

  # departure_time in seconds since epoch
  def fetch(departure_time)
    begin 
      puts "==== starting"
      puts @origin


      params = {origin: @origin, destination: @destination, departure_time: departure_time, key: @key}
      result = RestClient.get(@base, {params: params})
      puts "==== success"
      JSON.parse(result.body)["routes"].first["legs"].first["duration_in_traffic"]["value"]
      # puts result
      # result
    rescue RestClient::ExceptionWithResponse => e
      puts "==== failed"
      puts e
      puts e.response
      raise e
    end     
  end


end



# url = "#{base}origin=2223+Peachtree+Ln+Northbrook+IL"

