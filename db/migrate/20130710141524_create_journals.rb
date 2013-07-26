class CreateJournals < ActiveRecord::Migration
    def change
        create_table :journals do |t|
            t.belongs_to :publisher
            t.text :name
            t.text :note
            t.timestamps
        end
    end
end
