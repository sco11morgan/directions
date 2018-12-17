require 'sinatra'
# require 'sinatra/reloader' if development?
require 'chartkick'
require_relative "datastore"

get '/' do
  erb :index
end

__END__

@@ layout
<html>
<head>
  <title>Travel Time</title>
  <script>
  var Chartkick = {"language": "en"};
  </script>
  <script src="http://www.google.com/jsapi"></script>
  <script src="chartkick.js"></script>
</head>
<body>
  <%= yield %>
</body>
</html>

@@ index
<%= area_chart(Datastore.new.times_to, {title: "Travel time to work", xtitle: "Time", ytitle: "Duration"}) %>]
<%= area_chart(Datastore.new.times_from, {title: "Travel time from work", xtitle: "Time", ytitle: "Duration"}) %>]