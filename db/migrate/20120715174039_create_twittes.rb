class CreateTwittes < ActiveRecord::Migration
  def change
    create_table :twittes do |t|
      t.string :id_str, :limit=>36, :null=>false, :primary_key => true, :unique=>true
      t.string :from_user
      t.string :from_user_id_str
      t.string :profile_image_url
      t.string :text
      t.datetime :date
      t.integer :keyword_id, :null=>false

      t.timestamps
    end
  end
end
