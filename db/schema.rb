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

ActiveRecord::Schema[7.1].define(version: 2024_09_11_165952) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.bigint "week_id", null: false
    t.bigint "home_team_id", null: false
    t.bigint "away_team_id", null: false
    t.decimal "home_score", precision: 8, scale: 2
    t.decimal "away_score", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "processed"
    t.index ["away_team_id"], name: "index_games_on_away_team_id"
    t.index ["home_team_id"], name: "index_games_on_home_team_id"
    t.index ["week_id"], name: "index_games_on_week_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.decimal "dollars_owed", precision: 8, scale: 2
    t.decimal "dollars_won", precision: 8, scale: 2
    t.integer "wins"
    t.integer "losses"
    t.integer "ties"
    t.decimal "points_for", precision: 8, scale: 2
    t.decimal "points_against", precision: 8, scale: 2
    t.string "highest_week"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weeks", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "teams", column: "away_team_id"
  add_foreign_key "games", "teams", column: "home_team_id"
  add_foreign_key "games", "weeks"
end
