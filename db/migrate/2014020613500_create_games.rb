class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :min_players
      t.integer :max_players
      t.string :description
      t.integer :playing_time
      t.boolean :in_collection
    end
  end
end