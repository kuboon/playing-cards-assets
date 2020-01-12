require 'sinatra'
require 'yaml'


module Util
  module_function
  Dict = YAML.load_file("./api/ja.yaml")
  def parse_name(name)
    s,n = name.split(Dict["delimiter"])
    suit = parse_suit(s)
    num = parse_number(n)
    return [suit, num] if s && n
  end
  def parse_suit(s)
    Dict["suits"].find{|k,v|  k.to_s == s || v.include?(s)}&.first
  end
  def parse_number(n)
    Dict["numbers"].find{|k,v| k.to_s == n || v.include?(n)}&.first
  end
  def html(suit, num)
  <<-END
  <html>
  <head>
  <style>
  @media screen and (orientation: landscape) {
    html {
      /*transform: rotate(-90deg);*/
    }
  }
  img {
    height: 100%;
    object-fit: contain;
    width: 100%;
  }
  </style>
  </head>
  <body>
    <img src="/#{suit}/#{num}.svg" />
  </body>
  </html>
  END
  end
end

get '/api/cards' do
  name = params['name']
  suit = Util.parse_suit params['suit']
  number = Util.parse_number params['number']
  if suit && number
    body Util.html(suit, number)
  elsif sn = Util.parse_name(params['name'])
    body Util.html(*sn)
  else
    status 404
  end
end

# puts Util.parse_name("クラブのに")
run Sinatra::Application

