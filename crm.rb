require_relative "contact"
require "sinatra"

get '/' do
  redirect to('/home')
end

get '/home' do
  erb(:index)
end

get '/contacts' do
  @title = 'Contact List'
  @currect_time = Time.now
  @contact_list = Contact.all
  erb(:contacts)
end

get '/about' do
  erb(:about)
end

at_exit do
  ActiveRecord::Base.connection.close
end
