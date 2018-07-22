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

ActiveRecord::Schema.define(version: 2018_07_17_162128) do

  create_table "groups", force: :cascade do |t|
    t.integer "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_groups_on_league_id"
  end

  create_table "ladder_positions", force: :cascade do |t|
    t.integer "points", default: 0
    t.integer "group_id"
    t.integer "participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_ladder_positions_on_group_id"
    t.index ["participant_id"], name: "index_ladder_positions_on_participant_id"
  end

  create_table "league_matches", force: :cascade do |t|
    t.integer "round"
    t.integer "group_id"
    t.integer "participant1_id"
    t.integer "participant2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "score"
    t.index ["group_id"], name: "index_league_matches_on_group_id"
    t.index ["participant1_id"], name: "index_league_matches_on_participant1_id"
    t.index ["participant2_id"], name: "index_league_matches_on_participant2_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.integer "number_of_groups", default: 1
    t.integer "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "league_settings"
    t.index ["tournament_id"], name: "index_leagues_on_tournament_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_participants_on_name"
  end

  create_table "tournament_participants", force: :cascade do |t|
    t.integer "seeding", default: 0
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
    t.integer "discipline", default: 0
  end

end
