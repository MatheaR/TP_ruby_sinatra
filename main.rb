require 'sinatra'
require 'mongoid'
require 'slim'
require 'redcarpet'
require 'bootstrap'

configure do
    Mongoid.load!("./mongoid.yml")
    mime_type :css, 'text/css'
end

class Message
  include Mongoid::Document

  field :user,   type: String
  field :message,   type: String
end

get '/' do
  @title = "Viens tchatter !"
  erb :index
end

get '/tchat' do
  @messages = Message.all
  @title = "Viens tchatter !"
  erb :tchat
end

post '/login' do
    redirect to("/tchat")
end

post '/goMess' do
    @mess = Message.create(params[:message])
    redirect to("/tchat")
end
