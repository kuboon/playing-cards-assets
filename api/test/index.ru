require 'sinatra'

get '/*' do
    request.inspect
end

run Sinatra::Application

