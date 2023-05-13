# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_04_131117) do
  create_table "casts", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.string "character"
    t.string "cast"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_id"], name: "index_casts_on_work_id"
  end

  create_table "episode_rates", charset: "utf8mb4", force: :cascade do |t|
    t.integer "impressed"
    t.integer "comedy"
    t.integer "love"
    t.integer "excitement"
    t.integer "deep"
    t.integer "favorite_degree"
    t.bigint "episode_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_episode_rates_on_episode_id"
    t.index ["user_id"], name: "index_episode_rates_on_user_id"
  end

  create_table "episodes", charset: "utf8mb4", force: :cascade do |t|
    t.string "title"
    t.integer "episode_number"
    t.bigint "work_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_id"], name: "index_episodes_on_work_id"
  end

  create_table "releases", charset: "utf8mb4", force: :cascade do |t|
    t.integer "year"
    t.string "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  create_table "work_rates", charset: "utf8mb4", force: :cascade do |t|
    t.integer "impressed"
    t.integer "comedy"
    t.integer "love"
    t.integer "excitement"
    t.integer "deep"
    t.integer "favorite_degree"
    t.bigint "user_id", null: false
    t.bigint "work_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_work_rates_on_user_id"
    t.index ["work_id"], name: "index_work_rates_on_work_id"
  end

  create_table "works", primary_key: "annict_id", charset: "utf8mb4", force: :cascade do |t|
    t.string "title"
    t.integer "episode_count"
    t.string "media"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title_kana"
    t.bigint "release_id", null: false
    t.index ["annict_id"], name: "index_works_on_annict_id", unique: true
    t.index ["release_id"], name: "index_works_on_release_id"
    t.index ["title"], name: "index_works_on_title", unique: true
  end

  add_foreign_key "casts", "works", primary_key: "annict_id"
  add_foreign_key "episode_rates", "episodes"
  add_foreign_key "episode_rates", "users"
  add_foreign_key "episodes", "works", primary_key: "annict_id"
  add_foreign_key "work_rates", "users"
  add_foreign_key "work_rates", "works", primary_key: "annict_id"
  add_foreign_key "works", "releases"
end
