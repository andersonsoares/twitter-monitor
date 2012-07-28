class Keyword < ActiveRecord::Base
  
  resourcify
  
  attr_accessible :name
  
  belongs_to :user
  
  has_many :twittes, :dependent => :delete_all
  
  #validations
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :name, :on => :create, :case_sensitive => false, :message => "must be unique"

#   validates :name,
# #                  :format => { :with => /^[\w\d]+$/ },
#                   :format => { :with => /(^|\s)#([^ ]*)/, :message => "is not a hastag" },
#                   :length => { :minimum => 1, :message => "size to small"}
  
  #method to recover all twittes from Twitter database, and put then in our database
  def recover_all_twittes
    puts "BEGIN[#{Time.now.to_s}]: Recover all twittes from #{name}"
    
    #loop for pages
    loop = 1
    while( (query = Twitter.search(name+" -rt", :rpp=>100, :page=>loop).results).length != 0 )
      
      #prevents get twitter invalid query error
      if(loop == 16)
        puts "Finalizando..."
        break
      end
      
      puts "LOOP: #{loop} - QUERY LENGTH: #{query.length}"
      
      query.each do |t|

        Twitte.create(
         :id_str => t.id.to_s,
         :from_user => t.from_user,
         :from_user_id_str => t.from_user_id.to_s,
         :profile_image_url => t.profile_image_url,
         :keyword_id => id,
         :text => t.text,
         :date => t.created_at
        )
      end      

      loop += 1
    end

    puts "END: Recover all twittes from #{name}"
  end
  handle_asynchronously :recover_all_twittes, :run_at => Proc.new { 5.seconds.from_now }
  
  # method to get all twittes that have id greater than the last twitte from this Keyword
  # in our base
  def update_twittes
    
    puts "BEGIN[#{Time.now.to_s}]: Updating twittes from #{name}"
    #recover the last twitte(by recent date), and get its id_str(twitter id)
    most_recent_id = Twitte.order("date desc").where(:keyword_id => id).first.id_str
    puts "Most recent id: #{most_recent_id.to_s}"
    
    #loop for pages
    loop = 1
    while( (query = Twitter.search(name+" -rt", :rpp=>100, :page=>loop, :since_id=>most_recent_id).results).length != 0 )
      #prevents get twitter invalid query error
      if(loop == 16)
          puts "Finalizando..."
        break
      end
      
      puts "Loop page = #{loop}"
      puts "Total twittes in this page: #{query.length}"
      
      query.map do |t|
         Twitte.create(
           :id_str => t.id.to_s,
           :from_user => t.from_user,
           :from_user_id_str => t.from_user_id.to_s,
           :profile_image_url => t.profile_image_url,
           :keyword_id => id,
           :text => t.text,
           :date => t.created_at
         )
       end
       loop += 1
    end
    puts "END: Updating twittes from #{name}"
  end
  handle_asynchronously :update_twittes,  :run_at => Proc.new { 5.seconds.from_now }
  
  
  #class method that iterate over all keywords and update their twittes
  #calling each instance method update_twittes
  def self.update_twittes
    keywords = Keyword.all
    
    keywords.each do |k|
      UpdateTwittesWorker.perform_async(k.id, k.name)
      #k.update_twittes
    end
  end
  
end
