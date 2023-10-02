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

ActiveRecord::Schema[7.0].define(version: 2023_10_02_112156) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_bookmarks_on_post_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.float "balance"
    t.string "username"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "client_id"
  end

  create_table "contents", force: :cascade do |t|
    t.bigint "creator_id", null: false
    t.string "title"
    t.text "description"
    t.decimal "price"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_contents_on_creator_id"
  end

  create_table "creators", force: :cascade do |t|
    t.string "username"
    t.float "balance"
    t.string "portfolio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_favorites_on_client_id"
    t.index ["creator_id"], name: "index_favorites_on_creator_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.text "content"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "length"
    t.decimal "price", precision: 10, scale: 2
    t.integer "status", default: 0
    t.bigint "client_id"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["creator_id"], name: "index_orders_on_creator_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "creator_id", null: false
    t.text "content"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_posts_on_creator_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "creator_id", null: false
    t.float "amount"
    t.string "transaction_type"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_transactions_on_client_id"
    t.index ["creator_id"], name: "index_transactions_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.integer "follower_id"
    t.integer "following_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookmarks", "posts"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "contents", "creators"
  add_foreign_key "favorites", "clients"
  add_foreign_key "favorites", "creators"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "orders", "users", column: "client_id"
  add_foreign_key "orders", "users", column: "creator_id"
  add_foreign_key "posts", "creators"
  add_foreign_key "transactions", "clients"
  add_foreign_key "transactions", "creators"
end
