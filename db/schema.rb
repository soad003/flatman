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

ActiveRecord::Schema.define(version: 20140321054655) do

  create_table "billcategories", force: true do |t|
    t.integer  "flat_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bills", force: true do |t|
    t.float    "value"
    t.datetime "date"
    t.integer  "user_id"
    t.integer  "billcategory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bills_users", force: true do |t|
    t.integer "user_id"
    t.integer "bill_id"
  end

  create_table "flats", force: true do |t|
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "zip"
    t.string   "image_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "text"
    t.string   "header"
    t.boolean  "read"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "payer_id"
    t.float    "value"
    t.integer  "payee_id"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ressourceentries", force: true do |t|
    t.integer  "ressource_id"
    t.datetime "date"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ressources", force: true do |t|
    t.integer  "flat_id"
    t.string   "name"
    t.string   "unit"
    t.float    "pricePerUnit"
    t.float    "monthlyCost"
    t.float    "annualCost"
    t.float    "description"
    t.float    "startValue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shareditems", force: true do |t|
    t.string   "name"
    t.string   "tags"
    t.boolean  "available"
    t.string   "description"
    t.string   "sharingNote"
    t.string   "image_path"
    t.integer  "flat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shopping_lists", force: true do |t|
    t.string   "item_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shoppinglistitems", force: true do |t|
    t.string   "name"
    t.boolean  "checked"
    t.integer  "user_id"
    t.integer  "shoppinglist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shoppinglists", force: true do |t|
    t.string   "name"
    t.integer  "flat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "image_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
