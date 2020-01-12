require 'sinatra'

get '/*' do
  "request.inspect"
end

