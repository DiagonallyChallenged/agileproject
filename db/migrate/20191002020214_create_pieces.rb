class CreatePieces < ActiveRecord::Migration[5.2]
  def change
    create_table :pieces do |t|
      t.integer :x_location
      t.integer :y_location
      t.string :type
      t.boolean :active, default: true
      t.integer :game_id
      t.integer :user_id
      t.timestamps
    end
  end
end
