class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :advertisement_id, :null => false
      t.text :content, :null => false
      t.integer :user_id, :null => false
      t.timestamps
    end
  end
end
