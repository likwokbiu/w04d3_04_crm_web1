require_relative "contact"
require "sinatra"

get '/' do
  redirect to('/home')
end

get '/home' do
  @title = 'Home'
  erb :index
end

get '/contacts/new' do
  @title = 'New'
  erb :new
end

post '/contacts' do
  Contact.create(
  first_name: params[:first_name],
  last_name:  params[:last_name],
  email:      params[:email],
  note:       params[:note]
  )
  redirect to('/contacts')
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

get '/contacts/:id/edit' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    @title = 'Not found'
    erb :not_found
  end
end

put '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.update(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
    )
    redirect to('/contacts')
  else
    @title = 'Not found'
    erb :not_found
  end
end

delete '/contacts/:id' do
  @contact = Contact.find_by(params[:id].to_i)
  if @contact
    @contact.delete
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

get '/about' do
  @title = 'About'
  erb(:About)
end

at_exit do
  ActiveRecord::Base.connection.close
end
