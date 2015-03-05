require 'mongoid'

class User
  include Mongoid::Document

  field :pseudo,   type: String
  field :initiale, type: String
  has_many :messages
  validates_presence_of :pseudo, :initiale
end
