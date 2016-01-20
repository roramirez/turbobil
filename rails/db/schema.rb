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

ActiveRecord::Schema.define(version: 20141014020434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account", force: true do |t|
    t.text    "code"
    t.integer "admin_id"
    t.integer "customer_id"
    t.integer "status"
    t.text    "ip_auth"
    t.text    "password"
  end

  create_table "account_codec", force: true do |t|
    t.integer "account_id"
    t.integer "codec_id"
  end

  create_table "admin", force: true do |t|
    t.text     "name"
    t.string   "email",                  limit: 255,              null: false
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "admin", ["email"], name: "index_admin_on_email", unique: true, using: :btree
  add_index "admin", ["reset_password_token"], name: "index_admin_on_reset_password_token", unique: true, using: :btree

  create_table "call", force: true do |t|
    t.integer  "admin_id"
    t.integer  "customer_id"
    t.datetime "at"
    t.integer  "duration"
    t.integer  "provider_id"
    t.integer  "route_id"
    t.float    "cost"
    t.text     "destination"
    t.text     "ip"
    t.text     "hangupcause"
    t.integer  "price_customer_id"
    t.integer  "currency_id"
    t.text     "dialstatus"
    t.float    "price_for_customer"
  end

  add_index "call", ["at", "admin_id"], name: "idx_at_admin_on_call", using: :btree
  add_index "call", ["at", "customer_id"], name: "idx_at_customer_on_call", using: :btree

  create_table "codec", force: true do |t|
    t.text "name"
    t.text "code"
  end

  create_table "currency", force: true do |t|
    t.text  "sign"
    t.text  "name"
    t.text  "code"
    t.float "value_convert"
  end

  create_table "customer", force: true do |t|
    t.text     "name"
    t.string   "email",                  limit: 255,              null: false
    t.float    "credit"
    t.integer  "type_pay"
    t.integer  "customer_id"
    t.integer  "type_customer_id"
    t.integer  "admin_id"
    t.integer  "currency_id"
    t.integer  "price_customer_id"
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "customer", ["email"], name: "index_customer_on_email", unique: true, using: :btree
  add_index "customer", ["price_customer_id"], name: "index_customer_on_price_customer_id", using: :btree
  add_index "customer", ["reset_password_token"], name: "index_customer_on_reset_password_token", unique: true, using: :btree

  create_table "price_customer", force: true do |t|
    t.text    "name"
    t.float   "percent_recharge"
    t.integer "admin_id"
  end

  create_table "protocol", force: true do |t|
    t.text "name"
  end

  create_table "provider", force: true do |t|
    t.text    "name"
    t.text    "email"
    t.integer "admin_id"
    t.float   "balance"
    t.integer "priority"
    t.integer "status"
    t.text    "from_user"
    t.text    "host"
    t.text    "username"
    t.text    "password"
    t.integer "protocol_id"
  end

  create_table "provider_codec", force: true do |t|
    t.integer "provider_id"
    t.integer "codec_id"
    t.integer "priority"
  end

  create_table "rate", force: true do |t|
    t.integer "provider_id"
    t.integer "route_id"
    t.integer "priority"
    t.float   "price"
  end

  create_table "rate_customer", force: true do |t|
    t.integer "route_id"
    t.float   "value"
    t.integer "price_customer_id"
  end

  create_table "route", force: true do |t|
    t.text    "prefix"
    t.text    "name"
    t.integer "admin_id"
    t.float   "price_list"
  end

  create_table "type_customer", force: true do |t|
    t.text    "name"
    t.integer "admin_id"
  end

end
