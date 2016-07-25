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

ActiveRecord::Schema.define(version: 20160725121513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", id: false, force: :cascade do |t|
    t.string  "onetsoc_code",       limit: 10,                         null: false
    t.string  "element_id",         limit: 20,                         null: false
    t.string  "scale_id",           limit: 3,                          null: false
    t.decimal "data_value",                    precision: 5, scale: 2, null: false
    t.decimal "n",                             precision: 4
    t.decimal "standard_error",                precision: 5, scale: 2
    t.decimal "lower_ci_bound",                precision: 5, scale: 2
    t.decimal "upper_ci_bound",                precision: 5, scale: 2
    t.string  "recommend_suppress", limit: 1
    t.string  "not_relevant",       limit: 1
    t.date    "date_updated",                                          null: false
    t.string  "domain_source",      limit: 30,                         null: false
  end

  create_table "content_model_reference", primary_key: "element_id", id: :string, limit: 20, force: :cascade do |t|
    t.string "element_name", limit: 150,  null: false
    t.string "description",  limit: 1500, null: false
  end

  create_table "internal_abilities", force: :cascade do |t|
    t.string "onet_content_element_id"
    t.string "name",                    limit: 150
    t.string "description",             limit: 1500
  end

  create_table "occupation_data", primary_key: "onetsoc_code", id: :string, limit: 10, force: :cascade do |t|
    t.string "title",       limit: 150,  null: false
    t.string "description", limit: 1000, null: false
  end

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

  create_table "test_attempt_responses", force: :cascade do |t|
    t.integer  "test_attempt_id"
    t.integer  "question_id"
    t.integer  "question_response_id"
    t.datetime "submitted_at"
    t.index ["question_id"], name: "index_test_attempt_responses_on_question_id", using: :btree
    t.index ["question_response_id"], name: "index_test_attempt_responses_on_question_response_id", using: :btree
    t.index ["test_attempt_id"], name: "index_test_attempt_responses_on_test_attempt_id", using: :btree
  end

  create_table "test_attempts", force: :cascade do |t|
    t.integer  "test_id"
    t.integer  "user_id"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer  "ordered_question_ids",                  array: true
    t.integer  "current_question_id_index", default: 0
    t.index ["test_id"], name: "index_test_attempts_on_test_id", using: :btree
    t.index ["user_id"], name: "index_test_attempts_on_user_id", using: :btree
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
    t.boolean  "randomized", default: false
  end

  create_table "user_internal_abilities", force: :cascade do |t|
    t.integer "internal_ability_id"
    t.integer "user_id"
    t.decimal "level",               precision: 3, scale: 2
    t.index ["internal_ability_id"], name: "index_user_internal_abilities_on_internal_ability_id", using: :btree
    t.index ["user_id"], name: "index_user_internal_abilities_on_user_id", using: :btree
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

  add_foreign_key "abilities", "content_model_reference", column: "element_id", primary_key: "element_id", name: "abilities_element_id_fkey"
  add_foreign_key "abilities", "occupation_data", column: "onetsoc_code", primary_key: "onetsoc_code", name: "abilities_onetsoc_code_fkey"
end
