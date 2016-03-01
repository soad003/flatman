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

ActiveRecord::Schema.define(version: 20160301161131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billcategories", force: :cascade do |t|
    t.integer  "flat_id"
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bills", force: :cascade do |t|
    t.float    "value"
    t.datetime "date"
    t.integer  "user_id"
    t.integer  "billcategory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text",            limit: 255
    t.integer  "flat_id"
  end

  create_table "bills_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "bill_id"
  end

  create_table "flats", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "street",     limit: 255
    t.string   "city",       limit: 255
    t.string   "zip",        limit: 255
    t.string   "image_path", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "flats", ["name"], name: "index_flats_on_name", unique: true, using: :btree

  create_table "invites", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.integer  "flat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",      limit: 255
  end

  add_index "invites", ["email"], name: "index_invites_on_email", unique: true, using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "text",        limit: 255
    t.string   "header",      limit: 255
    t.boolean  "read"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "readers",                 default: [], array: true
    t.integer  "deleted",                 default: [], array: true
  end

  create_table "newsitems", force: :cascade do |t|
    t.string   "text",        limit: 255
    t.integer  "user_id"
    t.integer  "flat_id"
    t.integer  "newsitem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category",                default: 0
    t.integer  "action",                  default: 0
    t.integer  "key"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "payer_id"
    t.float    "value"
    t.integer  "payee_id"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flat_id"
  end

  add_index "payments", ["flat_id"], name: "index_payments_on_flat_id", using: :btree

  create_table "resourceentries", force: :cascade do |t|
    t.integer  "resource_id"
    t.date     "date"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "isFirst",     default: false
  end

  create_table "resources", force: :cascade do |t|
    t.integer  "flat_id"
    t.string   "name",         limit: 255
    t.string   "unit",         limit: 255
    t.float    "pricePerUnit"
    t.float    "monthlyCost",              default: 0.0
    t.float    "annualCost",               default: 0.0
    t.string   "description",  limit: 255
    t.float    "startValue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "startDate"
  end

  create_table "shareditems", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "tags",               limit: 255
    t.boolean  "available",                      default: true
    t.boolean  "hidden",                         default: false
    t.string   "description",        limit: 255
    t.string   "sharingNote",        limit: 255
    t.integer  "flat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "shoppinglistitems", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.boolean  "checked"
    t.integer  "user_id"
    t.integer  "shoppinglist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shoppinglists", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "flat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "flat_id"
    t.string   "email",            limit: 255
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "name",             limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.string   "image_path",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
