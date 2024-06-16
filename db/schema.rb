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

ActiveRecord::Schema[7.1].define(version: 2024_06_09_022326) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "grades", force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.integer "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.bigint "record_book_id"
    t.boolean "is_retake"
    t.index ["record_book_id"], name: "index_grades_on_record_book_id"
    t.index ["subject_id"], name: "index_grades_on_subject_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "form_of_education"
    t.bigint "curator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "specialization_id", null: false
    t.index ["curator_id"], name: "index_groups_on_curator"
    t.index ["curator_id"], name: "index_groups_on_curator_id"
    t.index ["specialization_id"], name: "index_groups_on_specialization_id"
  end

  create_table "groups_intermediate_attestations", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "intermediate_attestation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_groups_intermediate_attestations_on_group_id"
    t.index ["intermediate_attestation_id"], name: "idx_on_intermediate_attestation_id_e18abbf00a"
  end

  create_table "intermediate_attestations", force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.string "name"
    t.string "assessment_type"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "teacher_id"
    t.index ["subject_id"], name: "index_intermediate_attestations_on_subject_id"
    t.index ["teacher_id"], name: "index_intermediate_attestations_on_teacher_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "message"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications_users", force: :cascade do |t|
    t.bigint "notification_id", null: false
    t.bigint "user_id", null: false
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_id"], name: "index_notifications_users_on_notification_id"
    t.index ["user_id"], name: "index_notifications_users_on_user_id"
  end

  create_table "record_books", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "specialization_id", null: false
    t.bigint "group_id", null: false
    t.string "custom_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "retake_count", default: 0
    t.index ["group_id"], name: "index_record_books_on_group_id"
    t.index ["specialization_id"], name: "index_record_books_on_specialization_id"
    t.index ["user_id"], name: "index_record_books_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "semesters", force: :cascade do |t|
    t.string "name", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "semesters_subjects", id: false, force: :cascade do |t|
    t.bigint "semester_id", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["semester_id"], name: "index_semesters_subjects_on_semester_id"
    t.index ["subject_id"], name: "index_semesters_subjects_on_subject_id"
  end

  create_table "specialities_subjects", force: :cascade do |t|
    t.bigint "specialization_id", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["specialization_id"], name: "index_specialities_subjects_on_specialization_id"
    t.index ["subject_id"], name: "index_specialities_subjects_on_subject_id"
  end

  create_table "specializations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers_subjects", force: :cascade do |t|
    t.bigint "teacher_id"
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_teachers_subjects_on_subject_id"
    t.index ["teacher_id"], name: "index_teachers_subjects_on_teacher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "phone_number"
    t.date "date_of_birth"
    t.boolean "status"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "grades", "record_books"
  add_foreign_key "grades", "subjects"
  add_foreign_key "groups", "specializations"
  add_foreign_key "groups", "users", column: "curator_id"
  add_foreign_key "groups_intermediate_attestations", "groups"
  add_foreign_key "groups_intermediate_attestations", "intermediate_attestations"
  add_foreign_key "intermediate_attestations", "subjects"
  add_foreign_key "intermediate_attestations", "users", column: "teacher_id"
  add_foreign_key "notifications_users", "notifications"
  add_foreign_key "notifications_users", "users"
  add_foreign_key "record_books", "groups"
  add_foreign_key "record_books", "specializations"
  add_foreign_key "record_books", "users"
  add_foreign_key "semesters_subjects", "semesters"
  add_foreign_key "semesters_subjects", "subjects"
  add_foreign_key "specialities_subjects", "specializations"
  add_foreign_key "specialities_subjects", "subjects"
  add_foreign_key "teachers_subjects", "subjects"
  add_foreign_key "teachers_subjects", "users", column: "teacher_id"
end
