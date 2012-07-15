class Keyword < ActiveRecord::Base
  attr_accessible :name
  
  has_many :twittes, :dependent => :delete_all
  
  #validations
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  
  
end
