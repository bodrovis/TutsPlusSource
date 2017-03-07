class Book < ApplicationRecord
  has_attached_file :image,
                    styles: {
                        thumb: ["300x300#", :jpeg],
                        original: [:jpeg]
                    },
                    convert_options: {
                        thumb: "-quality 70 -strip",
                        original: "-quality 90"
                    },
                    #default_url: "/images/:style/missing.png"
                    storage: :s3,
                    s3_credentials: {
                        access_key_id: ENV["S3_KEY"],
                        secret_access_key: ENV["S3_SECRET"],
                        bucket: ENV["S3_BUCKET"]
                    },
                    s3_region: ENV["S3_REGION"],
                    s3_permissions: :private


  validates_attachment :image,
                       content_type: { content_type: /\Aimage\/.*\z/ },
                       size: { less_than: 1.megabyte }
    #validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    #validates_attachment_size :image, less_than: 1.megabyte
end
