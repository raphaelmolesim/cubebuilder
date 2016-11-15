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

ActiveRecord::Schema.define(version: 20161115152028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "architypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string   "name"
    t.string   "manaCost"
    t.integer  "cmc"
    t.string   "text"
    t.integer  "power"
    t.integer  "toughness"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "colors_list"
    t.string   "types_list"
    t.string   "subtypes_list"
  end

  create_table "cards_cubes", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "cube_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_cards_cubes_on_card_id", using: :btree
    t.index ["cube_id"], name: "index_cards_cubes_on_cube_id", using: :btree
  end

  create_table "cubes", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
