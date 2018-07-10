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

ActiveRecord::Schema.define(version: 2018_07_10_200349) do

  create_table "participants", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_participants_on_name"
  end

  create_table "tournament_participants", id: false, force: :cascade do |t|
    t.integer "seeding"
    t.integer "tournament_id"
    t.integer "participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_tournament_participants_on_participant_id"
    t.index ["tournament_id"], name: "index_tournament_participants_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name", null: false
    t.integer "format", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
