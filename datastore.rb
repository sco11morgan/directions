require "chronic"
require "pp"
require "pstore"
require_relative "navigate"

class Datastore

  def initialize
    @store = PStore.new("data.pstore")
  end

  def times
    @store.transaction { @store["work"].to_json }
  end  

  def times_to
    @store.transaction { @store["work"]["to"].map { |k,v| {k => (v / 60.0).round(1) } }.inject(:merge) }
  end  

  def times_from
    @store.transaction { @store["work"]["from"].map { |k,v| {k => (v / 60.0).round(1) } }.inject(:merge) }
  end  

  def roundtrip(origin, destination)
    @store.transaction { @store["work"] = {} }
    plan("to", origin, destination, Chronic.parse('monday 6:00 am').to_time)
    plan("from", destination, origin, Chronic.parse('monday 3:00 pm').to_time)
  end

  def plan(key, origin, destination, start_time)
    n = Navigate.new(origin, destination)

    @store.transaction { @store["work"][key] = {} }

    # every 10 minutes for 5 hours
    # times = (0..30).map { |counter| start_time + counter*10*60 }
    times = (0..30).map { |counter| start_time + counter*10*60 }
    times.each do |time|
      result = n.fetch(time.to_i)
      @store.transaction { @store["work"][key][time.to_s] = n.fetch(time.to_i) }
      # @store.transaction { @store["work"][key][time.strftime("%F %H:%M")] = n.fetch(time.to_i) }
    end    
  end

end