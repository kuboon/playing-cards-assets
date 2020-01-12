require 'sinatra'
require 'yaml'

module Util
  module_function
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

dict = YAML.load_file("./api/ja.yaml")
get '/api/cards' do
  name = params['name']
  s,n = name.split(dict["delimiter"])
  suit = dict["suits"].find{|k,v|  k.to_s == s || v.include?(s)}[0]
  num = dict["numbers"].find{|k,v| k.to_s == n || v.include?(n)}[0]
  body Util.html(suit, num)
end

run Sinatra::Application

