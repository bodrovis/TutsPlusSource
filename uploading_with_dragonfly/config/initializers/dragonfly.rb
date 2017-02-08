require 'dragonfly'
require 'dragonfly/s3_data_store'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "272435db349d6d6c7df6de8f609613b1df0d25584bbdc0ea7909128f95c5f7be"

  url_format "/media/:job/:name"

  if Rails.env.production?
    datastore :s3,
              bucket_name: ENV['S3_BUCKET'],
              access_key_id: ENV['S3_KEY'],
              secret_access_key: ENV['S3_SECRET'],
              region: ENV['S3_REGION'],
              url_scheme: 'https'
  else
    datastore :file,
              root_path: Rails.root.join('public/system/dragonfly', Rails.env),
              server_root: Rails.root.join('public')
  end

  define_url do |app, job, opts|
    thumb = Thumb.find_by_job(job.signature)
    if thumb
      app.datastore.url_for(thumb.uid, :scheme => 'https')
    else
      app.server.url_for(job)
    end
  end

  before_serve do |job, env|
    uid = job.store

    Thumb.create!(
        :uid => uid,
        :job => job.signature
    )
  end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
