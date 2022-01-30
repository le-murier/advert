class CreateViews < ActiveRecord::Migration[7.0]
  def change
    create_table :views do |t|
      t.integer :advert_id, :null => false
      t.integer :user_id, :null => false
      t.integer :number, :default => 0
      t.timestamps
    end
  end
end
