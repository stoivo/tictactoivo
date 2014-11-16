class CreateGamePlots < ActiveRecord::Migration
  def change
    create_table :game_plots do |t|
      t.integer :game_id
      t.integer :vertical
      t.integer :horizontal
      t.integer :selected_by_id
      t.integer :selected_turn

      t.timestamps
    end
    add_index :game_plots, :vertical
    add_index :game_plots, :horizontal
  end
end
