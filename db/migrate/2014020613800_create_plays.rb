class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.datetime :date # is this right?
      t.string :notes
      t.decimal :price
      t.integer :game_id
    end
  end
end