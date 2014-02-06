class CreatePlaysFriends < ActiveRecord::Migration
  def change
    create_table :plays_friends do |t|
      t.integer :plays_id
      t.integer :friends_id
    end
  end
end