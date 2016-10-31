class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.references :table, foreign_key: true, index: true
      t.integer :bet
      t.integer :seat
      t.integer :active_hand, default: 0
      t.json :hands_data

      t.timestamps
    end
  end
end
