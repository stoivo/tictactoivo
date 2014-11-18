class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :limit => 26
      t.string :epost, :limit => 100 , :default => "", :null =>false
      t.string :password_digest

      t.datetime :first_login
      t.datetime :last_login

      t.timestamps
    end
    add_index :users, :username
  end
end
