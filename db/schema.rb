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

ActiveRecord::Schema.define(version: 20160718150235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "question_responses", force: :cascade do |t|
    t.integer "question_id"
    t.string  "text"
    t.integer "points",      default: 0
    t.index ["question_id"], name: "index_question_responses_on_question_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.text    "text"
    t.integer "test_variable_id"
  end

  create_table "test_result_ranges", force: :cascade do |t|
    t.integer "test_result_id"
    t.integer "range_start"
    t.integer "range_stop"
    t.text    "result_message"
    t.decimal "attribute_score", precision: 4, scale: 2
    t.index ["test_result_id"], name: "index_test_result_ranges_on_test_result_id", using: :btree
  end

  create_table "test_results", force: :cascade do |t|
    t.integer "test_variable_id"
    t.string  "attribute_name"
    t.index ["test_variable_id"], name: "index_test_results_on_test_variable_id", using: :btree
  end

  create_table "test_variables", force: :cascade do |t|
    t.string  "name"
    t.integer "test_id"
    t.index ["test_id"], name: "index_test_variables_on_test_id", using: :btree
  end

  create_table "tests", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "time_limit"
    t.boolean  "published",  default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
