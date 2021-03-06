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

ActiveRecord::Schema.define(version: 20160119233147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ircnicks", force: :cascade do |t|
    t.text     "nick"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ircnicks", ["user_id"], name: "index_ircnicks_on_user_id", using: :btree

  create_table "plays", force: :cascade do |t|
    t.integer  "song_id"
    t.string   "nick",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "setlist_id"
    t.datetime "time"
  end

  add_index "plays", ["setlist_id"], name: "index_plays_on_setlist_id", using: :btree
  add_index "plays", ["song_id"], name: "index_plays_on_song_id", using: :btree

  create_table "setlists", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner"
    t.boolean  "live",                   default: false
    t.integer  "user_id"
    t.string   "type"
  end

  add_index "setlists", ["user_id"], name: "index_setlists_on_user_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "artist",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "youtube_id", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
