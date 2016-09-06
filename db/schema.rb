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

ActiveRecord::Schema.define(version: 20160906153907) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "user_id",        null: false
    t.string   "trackable_type", null: false
    t.integer  "trackable_id",   null: false
    t.integer  "discussion_id",  null: false
    t.string   "action",         null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["discussion_id"], name: "index_activities_on_discussion_id", using: :btree
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id", using: :btree
    t.index ["user_id"], name: "index_activities_on_user_id", using: :btree
  end

  create_table "boarding_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "user_id",     null: false
    t.integer  "canoe_id",    null: false
    t.datetime "accepted_at"
    t.integer  "acceptor_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id", "canoe_id"], name: "index_boarding_requests_on_user_id_and_canoe_id", unique: true, using: :btree
  end

  create_table "canoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "title",                                             null: false
    t.text     "body",                    limit: 65535
    t.integer  "user_id",                                           null: false
    t.string   "logo"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "boarding_requests_count",               default: 0
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer "canoe_id",                         null: false
    t.integer "user_id",                          null: false
    t.string  "name",              default: "기본"
    t.integer "discussions_count", default: 0
    t.index ["canoe_id"], name: "index_categories_on_canoe_id", using: :btree
    t.index ["user_id"], name: "index_categories_on_user_id", using: :btree
  end

  create_table "consensus_revisions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "discussion_id",               null: false
    t.integer  "user_id",                     null: false
    t.text     "body",          limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["discussion_id"], name: "index_consensus_revisions_on_discussion_id", using: :btree
    t.index ["user_id"], name: "index_consensus_revisions_on_user_id", using: :btree
  end

  create_table "consensuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "discussion_id",               null: false
    t.text     "body",          limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["discussion_id"], name: "index_consensuses_on_discussion_id", using: :btree
  end

  create_table "discussions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "user_id",                                  null: false
    t.integer  "canoe_id",                                 null: false
    t.string   "title"
    t.string   "body"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "opinions_count",               default: 0
    t.datetime "stroked_at",                               null: false
    t.text     "consensus",      limit: 65535
    t.integer  "category_id",                              null: false
    t.index ["canoe_id", "user_id"], name: "index_discussions_on_canoe_id_and_user_id", using: :btree
    t.index ["category_id"], name: "index_discussions_on_category_id", using: :btree
  end

  create_table "memberships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "user_id",    null: false
    t.integer  "canoe_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["canoe_id"], name: "index_memberships_on_canoe_id", using: :btree
    t.index ["user_id", "canoe_id"], name: "index_memberships_on_user_id_and_canoe_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_memberships_on_user_id", using: :btree
  end

  create_table "opinions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.text     "body",          limit: 65535
    t.integer  "discussion_id",               null: false
    t.integer  "user_id",                     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["discussion_id"], name: "index_opinions_on_discussion_id", using: :btree
    t.index ["user_id"], name: "index_opinions_on_user_id", using: :btree
  end

  create_table "proposal_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.text     "title",         limit: 65535
    t.integer  "user_id",                     null: false
    t.integer  "discussion_id",               null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["discussion_id"], name: "index_proposal_requests_on_discussion_id", using: :btree
    t.index ["user_id"], name: "index_proposal_requests_on_user_id", using: :btree
  end

  create_table "proposals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "title"
    t.integer  "user_id",                         null: false
    t.integer  "proposal_request_id",             null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "agree_votes_count",   default: 0
    t.integer  "block_votes_count",   default: 0
    t.index ["proposal_request_id"], name: "index_proposals_on_proposal_request_id", using: :btree
    t.index ["user_id"], name: "index_proposals_on_user_id", using: :btree
  end

  create_table "read_marks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "readable_type", null: false
    t.integer  "readable_id"
    t.string   "reader_type",   null: false
    t.integer  "reader_id"
    t.datetime "timestamp"
    t.index ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index", unique: true, using: :btree
  end

  create_table "sailing_diaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.text     "body",       limit: 65535
    t.integer  "user_id",                  null: false
    t.integer  "canoe_id",                 null: false
    t.date     "sailed_on"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["canoe_id", "user_id", "sailed_on"], name: "index_sailing_diaries_on_canoe_id_and_user_id_and_sailed_on", unique: true, using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "email",               default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider",                         null: false
    t.string   "uid",                              null: false
    t.string   "image"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "nickname",                         null: false
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
  end

  create_table "votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "proposal_id", null: false
    t.integer  "user_id",     null: false
    t.string   "choice",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["proposal_id", "user_id"], name: "index_votes_on_proposal_id_and_user_id", unique: true, using: :btree
    t.index ["proposal_id"], name: "index_votes_on_proposal_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
  end

end
