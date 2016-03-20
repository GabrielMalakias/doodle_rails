class CreateDoodleKeywords < ActiveRecord::Migration
  def change
    create_table :doodle_keywords do |t|
      t.string :name
      t.string :value
      t.string :type

      t.timestamps null: false
    end
  end
end
