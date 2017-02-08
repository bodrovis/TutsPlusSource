class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :singer
      t.string :image_uid

      t.timestamps
    end
  end
end
