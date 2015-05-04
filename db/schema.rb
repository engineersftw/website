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

ActiveRecord::Schema.define(version: 20150504123505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "episodes", force: :cascade do |t|
    t.string   "video_id"
    t.string   "title"
    t.datetime "published_at"
    t.text     "description"
    t.string   "image1"
    t.string   "image2"
    t.string   "image3"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "sort_order"
  end

  add_index "episodes", ["video_id"], name: "index_episodes_on_video_id", using: :btree

end
