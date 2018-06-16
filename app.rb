#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'Blog1.db'
	@db.results_as_hash = true
	return @db
end

def errors fields, page
		if fields.value?('')
		@error = 'Enter data in all fields'
  	end
	return erb page
end

before do
			init_db
end

configure do
	init_db # тк before do не исполняется при конфигурации
	@db.execute'create table if not exists "Posts"
	(
		"id" integer primary key autoincrement,
		"ptitle" text,
		"ptext" text,
		"pdate" date
	)'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"
end

get '/new' do
	erb :new
end

post '/new' do

	ptitle = params[:title]
	ptext = params[:text]

#	if ptitle.length <= 0
#		@error = 'Enter post title'
#		if ptext.length <= 0
#			@error << '</br> Enter post text'
#		end
#		return erb :new
#	end

	@db.execute 'insert into Posts (ptitle,ptext,pdate) values (?,?,datetime())', ptitle,ptext

errors params, :new

#	erb "<h3>Entered posts:</h3> </br> <h4><u>#{ptitle}</u></h4>#{ptext}"

end
