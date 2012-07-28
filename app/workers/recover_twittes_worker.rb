class RecoverTwittesWorker
  include Sidekiq::Worker
  
  def perform(keyword_id,name)
    
    puts 'Recovering twittes from #{name}'
    #loop for pages
    loop = 1
    while( (query = Twitter.search(name+" -rt", :rpp=>100, :page=>loop).results).length != 0 )
      
      #prevents get twitter invalid query error
      if(loop == 16)
        break
      end
      
      query.each do |t|

        Twitte.create(
         :id_str => t.id.to_s,
         :from_user => t.from_user,
         :from_user_id_str => t.from_user_id.to_s,
         :profile_image_url => t.profile_image_url,
         :keyword_id => keyword_id,
         :text => t.text,
         :date => t.created_at
        )
      end      

      loop += 1
    end
    puts 'Finish Recovering twittes from #{name}'    
  end
  
end