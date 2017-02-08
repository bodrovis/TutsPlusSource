class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.belongs_to :album, foreign_key: true
      t.string :track_uid

      t.timestamps
    end
  end
end
