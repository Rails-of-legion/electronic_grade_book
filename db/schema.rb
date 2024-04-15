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

ActiveRecord::Schema[7.1].define(version: 2024_04_15_124017) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "student_id", null: false
    t.date "date", null: false
    t.string "attendance_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "curator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curator_id"], name: "index_groups_on_curator"
    t.index ["curator_id"], name: "index_groups_on_curator_id"
  end

  create_table "intermediate_attestations", force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.string "name"
    t.date "date"
    t.integer "max_grade"
    t.string "assessment_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_intermediate_attestations_on_subject_id"
  end

  create_table "record_books", force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.bigint "student_id", null: false
    t.bigint "teacher_id", null: false
    t.bigint "intermediate_attestation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["intermediate_attestation_id"], name: "index_record_books_on_intermediate_attestation_id"
    t.index ["student_id"], name: "index_record_books_on_student_id"
    t.index ["subject_id"], name: "index_record_books_on_subject_id"
    t.index ["teacher_id"], name: "index_record_books_on_teacher_id"
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

  create_table "specializations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "specialization_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_students_on_group_id"
    t.index ["specialization_id"], name: "index_students_on_specialization_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "semester_id", null: false
    t.text "assessment_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["semester_id"], name: "index_subjects_on_semester_id"
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
    t.string "name"
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

  add_foreign_key "groups", "users", column: "curator_id"
  add_foreign_key "intermediate_attestations", "subjects"
  add_foreign_key "record_books", "intermediate_attestations"
  add_foreign_key "record_books", "students"
  add_foreign_key "record_books", "subjects"
  add_foreign_key "record_books", "users", column: "teacher_id"
  add_foreign_key "students", "groups"
  add_foreign_key "students", "specializations"
  add_foreign_key "students", "users"
  add_foreign_key "subjects", "semesters"
  add_foreign_key "teachers_subjects", "subjects"
  add_foreign_key "teachers_subjects", "users", column: "teacher_id"
end
