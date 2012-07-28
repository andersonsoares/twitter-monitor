class UpdateTwittesWorker
  include Sidekiq::Worker
  
  def perform(keyword_id, name)
    puts "Updating twittes from #{name}\n"
    #recover the last twitte(by recent date), and get its id_str(twitter id)
    most_recent_id = Twitte.order("date desc").where(:keyword_id => keyword_id).first.id_str

    
    #loop for pages
    loop = 1
    while( (query = Twitter.search(name+" -rt", :rpp=>100, :page=>loop, :since_id=>most_recent_id).results).length != 0 )
      #prevents get twitter invalid query error
      if(loop == 16)
        break
      end
      
      puts "#{name} - #{query.length} new twittes\n"
      
      query.map do |t|
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
    puts "Finish Updating twittes from #{name}\n"
  end
  
end