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

ActiveRecord::Schema.define(version: 20170115181540) do

  create_table "cell_automatons", force: :cascade do |t|
    t.string   "name"
    t.integer  "board_size"
    t.integer  "step"
    t.integer  "state_num"
    t.integer  "init_type"
    t.text     "neighbor_rule"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id",       default: 0,     null: false
    t.text     "init_rule",     default: "",    null: false
    t.integer  "width",         default: 1,     null: false
    t.integer  "height",        default: 1,     null: false
    t.boolean  "pattern",       default: false, null: false
  end

  create_table "cell_variables", force: :cascade do |t|
    t.string   "name"
    t.float    "value"
    t.integer  "cell_automaton_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "cells", force: :cascade do |t|
    t.string   "color"
    t.integer  "cell_automaton_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "variables", force: :cascade do |t|
    t.string   "name"
    t.float    "value"
    t.integer  "cell_automaton_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
