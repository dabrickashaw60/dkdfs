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

ActiveRecord::Schema.define(version: 2025_08_14_153747) do

  create_table "drafted_player_week_stats", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "week_id", null: false
    t.bigint "player_id", null: false
    t.string "roster_position", null: false
    t.decimal "pct_drafted", precision: 5, scale: 2
    t.decimal "fpts", precision: 7, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_drafted_player_week_stats_on_player_id"
    t.index ["week_id", "player_id"], name: "index_drafted_player_week_stats_on_week_id_and_player_id", unique: true
    t.index ["week_id"], name: "index_drafted_player_week_stats_on_week_id"
  end

  create_table "games", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
    t.bigint "week_id", null: false
    t.bigint "home_team_id", null: false
    t.bigint "away_team_id", null: false
    t.decimal "home_score", precision: 8, scale: 2
    t.decimal "away_score", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "processed"
    t.string "season"
    t.index ["away_team_id"], name: "index_games_on_away_team_id"
    t.index ["home_team_id"], name: "index_games_on_home_team_id"
    t.index ["week_id"], name: "index_games_on_week_id"
  end

  create_table "players", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "team_seasons", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "season"
    t.integer "wins"
    t.integer "losses"
    t.integer "ties"
    t.float "points_for"
    t.float "points_against"
    t.string "highest_week"
    t.float "dollars_owed"
    t.float "dollars_won"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_team_seasons_on_team_id"
  end

  create_table "teams", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
    t.string "name"
    t.decimal "dollars_owed", precision: 8, scale: 2
    t.decimal "dollars_won", precision: 8, scale: 2
    t.integer "wins"
    t.integer "losses"
    t.integer "ties"
    t.decimal "points_for", precision: 8, scale: 2
    t.decimal "points_against", precision: 8, scale: 2
    t.string "highest_week"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "season"
  end

  create_table "users", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "week_team_lineups", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "week_id", null: false
    t.bigint "team_id", null: false
    t.text "lineup_text"
    t.decimal "points", precision: 7, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_week_team_lineups_on_team_id"
    t.index ["week_id", "team_id"], name: "index_week_team_lineups_on_week_id_and_team_id", unique: true
    t.index ["week_id"], name: "index_week_team_lineups_on_week_id"
  end

  create_table "weeks", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "season"
  end

  add_foreign_key "drafted_player_week_stats", "players"
  add_foreign_key "drafted_player_week_stats", "weeks"
  add_foreign_key "games", "teams", column: "away_team_id"
  add_foreign_key "games", "teams", column: "home_team_id"
  add_foreign_key "games", "weeks"
  add_foreign_key "team_seasons", "teams"
  add_foreign_key "week_team_lineups", "teams"
  add_foreign_key "week_team_lineups", "weeks"
end
