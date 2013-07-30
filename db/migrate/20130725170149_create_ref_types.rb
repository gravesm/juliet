class CreateRefTypes < ActiveRecord::Migration
  def change
    create_table :ref_types do |t|
      t.string :type_name

      t.timestamps
    end
  end
end
