# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_08_133933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.integer "author_id"
    t.string "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "episodes", id: :serial, force: :cascade do |t|
    t.string "video_id"
    t.string "title"
    t.datetime "published_at"
    t.text "description"
    t.string "image1"
    t.string "image2"
    t.string "image3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sort_order"
    t.boolean "active", default: true, null: false
    t.integer "video_site", default: 1, null: false
    t.integer "view_count", default: 0
    t.index ["video_id"], name: "index_episodes_on_video_id"
  end

  create_table "featured_videos", id: :serial, force: :cascade do |t|
    t.integer "episode_id", null: false
    t.integer "sequence", default: 0, null: false
    t.boolean "active", default: true, null: false
  end

  create_table "organizations", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "website"
    t.string "twitter"
    t.string "contact_person"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "slug"
    t.index ["slug"], name: "index_organizations_on_slug"
    t.index ["twitter"], name: "index_organizations_on_twitter"
  end

  create_table "playlist_categories", id: :serial, force: :cascade do |t|
    t.string "title"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlist_items", id: :serial, force: :cascade do |t|
    t.integer "playlist_id", null: false
    t.integer "episode_id", null: false
    t.integer "sort_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_playlist_items_on_episode_id"
    t.index ["playlist_id"], name: "index_playlist_items_on_playlist_id"
    t.index ["sort_order"], name: "index_playlist_items_on_sort_order"
  end

  create_table "playlists", id: :serial, force: :cascade do |t|
    t.string "playlist_id"
    t.string "name"
    t.text "description"
    t.date "publish_date"
    t.string "image"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "website"
    t.string "hashtag"
    t.integer "playlist_category_id"
    t.string "slug"
    t.index ["active"], name: "index_playlists_on_active"
    t.index ["playlist_category_id"], name: "index_playlists_on_playlist_category_id"
    t.index ["playlist_id"], name: "index_playlists_on_playlist_id"
  end

  create_table "presenters", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.text "biography"
    t.string "twitter"
    t.string "email"
    t.string "website"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "byline"
    t.string "avatar_url"
    t.index ["twitter"], name: "index_presenters_on_twitter"
  end

  create_table "sub_playlists", id: :serial, force: :cascade do |t|
    t.integer "playlist_id", null: false
    t.integer "sub_playlist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sequence", default: 1, null: false
    t.index ["playlist_id"], name: "index_sub_playlists_on_playlist_id"
    t.index ["sub_playlist_id"], name: "index_sub_playlists_on_sub_playlist_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "twitter"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "video_links", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.integer "episode_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_video_links_on_episode_id"
  end

  create_table "video_organizations", id: :serial, force: :cascade do |t|
    t.integer "episode_id"
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_video_organizations_on_episode_id"
    t.index ["organization_id"], name: "index_video_organizations_on_organization_id"
  end

  create_table "video_presenters", id: :serial, force: :cascade do |t|
    t.integer "episode_id"
    t.integer "presenter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_video_presenters_on_episode_id"
    t.index ["presenter_id"], name: "index_video_presenters_on_presenter_id"
  end

  add_foreign_key "video_links", "episodes"
  add_foreign_key "video_organizations", "episodes"
  add_foreign_key "video_organizations", "organizations"
  add_foreign_key "video_presenters", "episodes"
  add_foreign_key "video_presenters", "presenters"
end
