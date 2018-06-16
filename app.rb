#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"
end

get '/new' do
	erb :new
end

post '/new' do
	posttitle = params[:title]
	posttext = params[:text]

	erb "<h3>Entered posts:</h3> </br> <h4><u>#{posttitle}</u></h4>#{posttext}"
end
