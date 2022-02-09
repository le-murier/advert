class CreateAdvertisements < ActiveRecord::Migration[7.0]
  def change
    create_table :advertisements do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.integer :user_id, :null => false
      t.string :status
      t.integer :views_number
      t.timestamps
    end
  end
end
