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

ActiveRecord::Schema.define(version: 20161031051149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.integer  "table_id"
    t.integer  "bet"
    t.integer  "seat"
    t.integer  "active_hand", default: 0
    t.json     "hands_data"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["table_id"], name: "index_players_on_table_id", using: :btree
  end

  create_table "tables", force: :cascade do |t|
    t.json     "shoe_data"
    t.json     "dealer_hand_data"
    t.integer  "active_player",    default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_foreign_key "players", "tables"
end
