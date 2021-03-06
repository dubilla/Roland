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

ActiveRecord::Schema.define(version: 20180225015751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entrants", force: :cascade do |t|
    t.integer "player_id",     null: false
    t.integer "tournament_id"
  end

  add_index "entrants", ["player_id"], name: "index_entrants_on_player_id", using: :btree
  add_index "entrants", ["tournament_id"], name: "index_entrants_on_tournament_id", using: :btree

  create_table "entries", force: :cascade do |t|
    t.integer "group_tournament_id", null: false
    t.integer "user_id",             null: false
    t.string  "name"
  end

  add_index "entries", ["group_tournament_id"], name: "index_entries_on_group_tournament_id", using: :btree
  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "group_memberships", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "group_memberships", ["group_id", "user_id"], name: "index_group_memberships_on_group_id_and_user_id", using: :btree
  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id", using: :btree
  add_index "group_memberships", ["user_id", "group_id"], name: "index_group_memberships_on_user_id_and_group_id", using: :btree
  add_index "group_memberships", ["user_id"], name: "index_group_memberships_on_user_id", using: :btree

  create_table "group_tournaments", force: :cascade do |t|
    t.integer "group_id",      null: false
    t.integer "tournament_id"
  end

  add_index "group_tournaments", ["group_id"], name: "index_group_tournaments_on_group_id", using: :btree
  add_index "group_tournaments", ["tournament_id"], name: "index_group_tournaments_on_tournament_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matchups", force: :cascade do |t|
    t.integer  "tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "slot_id",       null: false
    t.integer  "external_id"
  end

  add_index "matchups", ["slot_id"], name: "index_matchups_on_slot_id", using: :btree

  create_table "opponents", force: :cascade do |t|
    t.integer  "matchup_id", null: false
    t.integer  "entrant_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "winner"
  end

  add_index "opponents", ["entrant_id"], name: "index_opponents_on_entrant_id", using: :btree
  add_index "opponents", ["matchup_id"], name: "index_opponents_on_matchup_id", using: :btree

  create_table "picks", force: :cascade do |t|
    t.integer  "entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "slot_id"
    t.integer  "entrant_id"
    t.boolean  "winner"
  end

  add_index "picks", ["entrant_id"], name: "index_picks_on_entrant_id", using: :btree
  add_index "picks", ["slot_id"], name: "index_picks_on_slot_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "external_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slots", force: :cascade do |t|
    t.integer  "tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "ancestry"
  end

  add_index "slots", ["ancestry"], name: "index_slots_on_ancestry", using: :btree

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "locked"
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
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "entrants", "players"
  add_foreign_key "entrants", "tournaments"
  add_foreign_key "entries", "group_tournaments"
  add_foreign_key "entries", "users"
  add_foreign_key "group_memberships", "groups"
  add_foreign_key "group_memberships", "users"
  add_foreign_key "group_tournaments", "groups"
  add_foreign_key "group_tournaments", "tournaments"
  add_foreign_key "picks", "entrants"
  add_foreign_key "picks", "slots"
end
