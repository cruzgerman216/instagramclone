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

ActiveRecord::Schema.define(version: 2020_06_21_041434) do

  create_table "comments", force: :cascade do |t|
    t.string "comment"
    t.integer "post_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "user_id"
    t.integer "following_id"
  end

  create_table "hearts", force: :cascade do |t|
    t.integer "post_id"
    t.integer "user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "comment_id"
    t.string "img_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "firstname"
    t.string "lastname"
    t.string "username"
    t.string "profile_img"
    t.string "bio"
    t.boolean "privacy"
  end

end
