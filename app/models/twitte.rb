class Twitte < ActiveRecord::Base
  
  attr_accessible :date, :from_user, :from_user_id_str, :id_str, :keyword_id, :profile_image_url, :text
  
  belongs_to :keyword
  
  validates_uniqueness_of :id_str, :on => :create
  
  
end
