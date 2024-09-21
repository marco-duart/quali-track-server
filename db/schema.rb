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

ActiveRecord::Schema[7.1].define(version: 2024_09_19_184927) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.decimal "score"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "evaluation_id"
    t.bigint "question_id"
    t.bigint "user_id"
    t.index ["evaluation_id"], name: "index_answers_on_evaluation_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "critical_fields", force: :cascade do |t|
    t.string "title"
    t.decimal "discount_percentage"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "evaluation_id"
    t.index ["evaluation_id"], name: "index_critical_fields_on_evaluation_id"
  end

  create_table "evaluation_critical_fields", force: :cascade do |t|
    t.bigint "evaluation_id", null: false
    t.bigint "critical_field_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["critical_field_id"], name: "index_evaluation_critical_fields_on_critical_field_id"
    t.index ["evaluation_id"], name: "index_evaluation_critical_fields_on_evaluation_id"
  end

  create_table "evaluation_questions", force: :cascade do |t|
    t.bigint "evaluation_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_evaluation_questions_on_evaluation_id"
    t.index ["question_id"], name: "index_evaluation_questions_on_question_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.datetime "date"
    t.text "comment"
    t.decimal "total_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.bigint "monitor_id"
    t.bigint "team_id"
    t.index ["employee_id"], name: "index_evaluations_on_employee_id"
    t.index ["monitor_id"], name: "index_evaluations_on_monitor_id"
    t.index ["team_id"], name: "index_evaluations_on_team_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "score"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "evaluation_id"
    t.index ["evaluation_id"], name: "index_questions_on_evaluation_id"
  end

  create_table "signatures", force: :cascade do |t|
    t.integer "status", default: 0
    t.datetime "signed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "evaluation_id"
    t.bigint "manager_id"
    t.bigint "employee_id"
    t.index ["employee_id"], name: "index_signatures_on_employee_id"
    t.index ["evaluation_id"], name: "index_signatures_on_evaluation_id"
    t.index ["manager_id"], name: "index_signatures_on_manager_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "manager_id"
    t.index ["manager_id"], name: "index_teams_on_manager_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.bigint "team_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "answers", "evaluations"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "critical_fields", "evaluations"
  add_foreign_key "evaluation_critical_fields", "critical_fields"
  add_foreign_key "evaluation_critical_fields", "evaluations"
  add_foreign_key "evaluation_questions", "evaluations"
  add_foreign_key "evaluation_questions", "questions"
  add_foreign_key "evaluations", "teams"
  add_foreign_key "evaluations", "users", column: "employee_id"
  add_foreign_key "evaluations", "users", column: "monitor_id"
  add_foreign_key "questions", "evaluations"
  add_foreign_key "signatures", "evaluations"
  add_foreign_key "signatures", "users", column: "employee_id"
  add_foreign_key "signatures", "users", column: "manager_id"
  add_foreign_key "teams", "users", column: "manager_id"
  add_foreign_key "users", "teams"
end
