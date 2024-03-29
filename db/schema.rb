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

ActiveRecord::Schema.define(version: 20150322123810) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "families", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "family_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: :cascade do |t|
    t.string   "invite_token"
    t.datetime "created_at"
    t.datetime "sent_at"
    t.datetime "accepted_at"
    t.integer  "sender_id",                        null: false
    t.integer  "family_id",                        null: false
    t.string   "status",       default: "pending"
    t.string   "email",                            null: false
    t.string   "name",                             null: false
  end

  add_index "invitations", ["invite_token"], name: "index_invitations_on_invite_token", unique: true, using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "body",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid",          null: false
    t.string   "provider",     null: false
    t.string   "email",        null: false
    t.string   "name",         null: false
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "invite_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
