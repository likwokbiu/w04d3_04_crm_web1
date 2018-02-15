require_relative "contact"
require "sinatra"

get '/' do
  redirect to('/home')
end

get '/home' do
  @title = 'Home'
  erb :index
end

get '/add' do
  @title = 'Add'
  erb :add
end

get '/contacts' do
  @title = 'Contacts'
  @contacts_list = Contact.all
  erb :contacts
end

get '/contacts/:id' do
  @title = 'Contact Informations'
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    erb :show_contact
  else
    @title = 'Not found'
    erb :not_found
  end
end

get '/about' do
  @title = 'About'
  erb(:About)
end

at_exit do
  ActiveRecord::Base.connection.close
end
