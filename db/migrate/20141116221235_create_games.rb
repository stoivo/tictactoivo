class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :started_by_id
      t.integer :winner_id
      t.integer :losser_id
      t.integer :first_player_id
      t.integer :secound_player_id
      t.integer :turn, default: 1
      t.integer :rows, null: false
      t.integer :columns, null: false
      t.integer :length_to_win, null: false
      t.string :mode
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end
