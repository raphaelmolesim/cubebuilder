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

ActiveRecord::Schema.define(version: 20161229181722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "plperl"
  enable_extension "hstore"
  enable_extension "pg_stat_statements"
  enable_extension "pgcrypto"
  enable_extension "unaccent"

  create_table "archetypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_archetypes_on_user_id", using: :btree
  end

  create_table "archetypes_in_cubes", force: :cascade do |t|
    t.integer  "cube_id"
    t.integer  "archetype_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "cube_players"
    t.index ["archetype_id"], name: "index_archetypes_in_cubes_on_archetype_id", using: :btree
    t.index ["cube_id"], name: "index_archetypes_in_cubes_on_cube_id", using: :btree
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
    t.integer  "split_card_id"
  end

  create_table "cardsets", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "archetype_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["archetype_id"], name: "index_cardsets_on_archetype_id", using: :btree
    t.index ["card_id"], name: "index_cardsets_on_card_id", using: :btree
  end

  create_table "cubes", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_cubes_on_user_id", using: :btree
  end

  create_table "selected_cards", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "cube_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "archetype_id"
    t.index ["archetype_id"], name: "index_selected_cards_on_archetype_id", using: :btree
    t.index ["card_id", "cube_id", "archetype_id"], name: "index_selected_cards_on_card_id_and_cube_id_and_archetype_id", unique: true, using: :btree
    t.index ["card_id"], name: "index_selected_cards_on_card_id", using: :btree
    t.index ["cube_id"], name: "index_selected_cards_on_cube_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "cube_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_wishlists_on_card_id", using: :btree
    t.index ["cube_id"], name: "index_wishlists_on_cube_id", using: :btree
  end

end
