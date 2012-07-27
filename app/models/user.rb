class User < ActiveRecord::Base
	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable :registerable, :recoverable,
  devise :database_authenticatable, :registerable,
          :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_name
  # attr_accessible :title, :body
  
  validates_uniqueness_of :user_name, :on => :create, :message => "already exists"
  
  has_many :keywords
  
end
