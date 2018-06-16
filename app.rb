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

	@results = @db.execute 'select * from Posts order by id desc'

	erb :index
end

get '/new' do
	erb :new
end

post '/new' do

	ptitle = params[:title]
	ptext = params[:text]

	if params.value?('')
			@error = 'Enter data in all fields'
	  return erb :new
	end

	@db.execute 'insert into Posts (ptitle,ptext,pdate) values (?,?,datetime())', ptitle,ptext

	redirect to '/'

#	erb "<h3>Entered posts:</h3> </br> <h4><u>#{ptitle}</u></h4>#{ptext}"

end
# обработчик для вывода инфо о посте
get '/details:post_id' do
		post_id = params[:post_id]

		results = @db.execute 'select * from Posts where id = ?', [post_id]
		@row = results[0]

		erb :details
end
