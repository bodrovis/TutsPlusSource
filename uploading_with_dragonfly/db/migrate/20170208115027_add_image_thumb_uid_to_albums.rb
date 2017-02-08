class AddImageThumbUidToAlbums < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :image_thumb_uid, :string
  end
end
