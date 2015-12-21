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

ActiveRecord::Schema.define(version: 20151221171930) do

  create_table "cell_automatons", force: :cascade do |t|
    t.string   "name"
    t.integer  "board_size"
    t.integer  "step"
    t.integer  "state_num"
    t.integer  "init_type"
    t.text     "neighbor_rule"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "colors"
  end

  create_table "lifegames", force: :cascade do |t|
    t.integer  "board_size"
    t.integer  "step"
    t.integer  "state_num"
    t.integer  "init_type"
    t.integer  "state_count_range"
    t.integer  "live_count_min"
    t.integer  "live_count_max"
    t.integer  "retention_count_min"
    t.integer  "retention_count_max"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

end
