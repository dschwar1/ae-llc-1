# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20180605053219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "employee_number"
    t.integer  "department_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "client"
    t.string   "notes"
    t.integer  "job_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scope_times", force: :cascade do |t|
    t.datetime "week"
    t.integer  "completion_rate"
    t.integer  "scope_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "scopes", force: :cascade do |t|
    t.string   "scope_number"
    t.string   "notes"
    t.string   "description"
    t.boolean  "extra"
    t.integer  "estimated_hours"
    t.integer  "hours"
    t.float    "value"
    t.datetime "estimated_gc_due_date"
    t.datetime "actual_gc_due_date"
    t.integer  "crew_size"
    t.integer  "job_id"
    t.integer  "department_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "work_days", force: :cascade do |t|
    t.datetime "day"
    t.integer  "job_id"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
