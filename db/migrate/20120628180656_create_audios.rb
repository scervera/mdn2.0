class CreateAudios < ActiveRecord::Migration
  def self.up
    create_table :audios do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :audios
  end
end
