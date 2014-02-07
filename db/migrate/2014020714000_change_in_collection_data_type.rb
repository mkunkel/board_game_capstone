class ChangeInCollectionType < ActiveRecord::Migration
  def self.up
   change_column :games, :in_collection, :integer
  end

  def self.down
   change_column :games, :in_collection, :boolean
  end
end