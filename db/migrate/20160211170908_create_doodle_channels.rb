class CreateDoodleChannels < ActiveRecord::Migration
  def change
    create_table :doodle_channels do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
