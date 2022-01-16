class CreateAdvertisements < ActiveRecord::Migration[7.0]
  def change
    create_table :advertisements do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.string :user_id, :null => false
      t.integer :status
      t.integer :views
      t.timestamps
    end
  end
end
