# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141120213441) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_plots", force: true do |t|
    t.integer  "game_id"
    t.integer  "vertical"
    t.integer  "horizontal"
    t.integer  "selected_by_id"
    t.integer  "selected_turn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_plots", ["horizontal"], name: "index_game_plots_on_horizontal", using: :btree
  add_index "game_plots", ["vertical"], name: "index_game_plots_on_vertical", using: :btree

  create_table "games", force: true do |t|
    t.integer  "started_by_id"
    t.integer  "winner_id"
    t.integer  "losser_id"
    t.integer  "first_player_id"
    t.integer  "secound_player_id"
    t.integer  "turn",              default: 1
    t.integer  "rows",                          null: false
    t.integer  "columns",                       null: false
    t.integer  "length_to_win",                 null: false
    t.string   "mode"
    t.date     "start_at"
    t.date     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",        limit: 26
    t.string   "epost",           limit: 100, default: "",    null: false
    t.string   "password_digest"
    t.datetime "first_login"
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                       default: false
  end

  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
