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

ActiveRecord::Schema.define(version: 2019_02_17_204017) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.string "answer"
    t.integer "client_id"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "client_token"
    t.integer "request_id"
    t.string "professional_email"
    t.index ["client_id"], name: "index_answers_on_client_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["request_id"], name: "index_answers_on_request_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "service"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "phone_number"
    t.index ["email"], name: "index_clients_on_email", unique: true
  end

  create_table "payments", force: :cascade do |t|
    t.integer "client_id"
    t.integer "project_id"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "professional_id"
    t.string "pesapal_status"
    t.string "payment_type"
    t.integer "status"
    t.string "pesapal_transaction_tracking_id"
    t.string "trans_id"
    t.datetime "trans_time"
    t.string "msisdn"
    t.string "mpesa_status"
  end

  create_table "professionals", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "city"
    t.string "country"
    t.string "email"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "service"
    t.string "password_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "business_name"
    t.text "uniqueness_comment"
    t.date "career_start_date"
    t.string "specialization"
    t.string "phone_number"
    t.text "bio"
    t.string "picture"
    t.string "google_picture_url"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "client_id"
    t.integer "professional_id"
    t.string "status"
    t.integer "quotation_id"
    t.datetime "due"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "request_id"
    t.decimal "paid", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "debit_balance", precision: 10, scale: 2, default: "0.0", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text "question"
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "answer_type"
    t.integer "category_id"
    t.index ["category_id"], name: "index_questions_on_category_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.string "details"
    t.integer "professional_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "quotation_document"
    t.integer "client_id"
    t.integer "request_id"
    t.string "status"
    t.decimal "amount", precision: 10, scale: 2
    t.index ["professional_id"], name: "index_quotations_on_professional_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "service"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "professional_id"
    t.integer "client_id"
    t.string "status", default: "Not Sent"
    t.index ["client_id"], name: "index_requests_on_client_id"
    t.index ["professional_id"], name: "index_requests_on_professional_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "client_id"
    t.integer "professional_id"
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
  end

end
