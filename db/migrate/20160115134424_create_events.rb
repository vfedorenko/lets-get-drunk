class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
