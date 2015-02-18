require 'sinatra'
require 'mongoid'
require 'slim'
require 'redcarpet'
require 'bootstrap'

enable :sessions

configure do
    Mongoid.load!("./mongoid.yml")
    mime_type :css, 'text/css'
end

class User
  include Mongoid::Document

  field :pseudo,   type: String
  field :initiale, type: String
  has_many :messages
  validates_presence_of :pseudo, :initiale
end

class Message
  include Mongoid::Document


  field :message,   type: String
  belongs_to :user
end

get '/' do
  erb :index
end

post '/' do
  erb :index
end

get '/tchat' do
  if(!session[:id].nil? && !session[:user].nil?)
    @userId = session[:id]
    @userSession = session[:user]
    @messages = Message.all
    @title = "Viens tchatter !"
    erb :tchat
  else
    redirect to("/haha")
  end
end

get '/haha' do
  erb :haha
end

post '/login' do
    if User.where(pseudo: params[:user]).exists?
      @a = User.find_by(pseudo: params[:user])
      session[:id] = @a.id
      session[:user] = @a.pseudo
      redirect to("/tchat")
    else
      # ifparams.has_key?(:user) && params.has_key?(:initiale)
      if params[:user].present? && params[:initiale].present?
        @user = User.create(pseudo: params[:user], initiale: params[:initiale])
        puts "Successfully registered"
         @b = User.find_by(pseudo: params[:user])
        session[:id] = @b.id
        session[:user] = @b.pseudo
        redirect to("/tchat")
      else
        puts params[:user]
        puts params[:initiale]
        # redirect to("/haha")
      end
    end
end

post '/goMess' do
    @mess = Message.create(params[:message])
    redirect to("/tchat")
end

post '/deco' do
    [:user, :id].each { |k| session.delete(k) }
    redirect to("/")
end

post '/supAll' do
    @supAll = Message.all_in(:user_id => [params[:user_id]]).destroy_all
    redirect to("/tchat")
end

post '/supOne' do
    @supOne = Message.any_in(:_id => [params[:id]]).destroy_all
    redirect to("/tchat")
end
