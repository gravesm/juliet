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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130725170149) do

  create_table "entity_refs", :force => true do |t|
    t.text     "refvalue"
    t.integer  "refable_id"
    t.string   "refable_type"
    t.integer  "ref_type_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "entity_refs", ["refable_id"], :name => "index_entity_refs_on_refable_id"

  create_table "journals", :force => true do |t|
    t.integer  "publisher_id"
    t.text     "name"
    t.text     "note"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "policies", :force => true do |t|
    t.text     "contact"
    t.text     "note"
    t.integer  "embargo"
    t.text     "requirements"
    t.string   "method_of_acquisition"
    t.boolean  "opt_out_required"
    t.boolean  "should_request"
    t.text     "message"
    t.integer  "policyable_id"
    t.string   "policyable_type"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "policies", ["policyable_id"], :name => "index_policies_on_policyable_id"

  create_table "publishers", :force => true do |t|
    t.text     "note"
    t.text     "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ref_types", :force => true do |t|
    t.string   "type_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
