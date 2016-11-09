class DeleteJob < ApplicationJob
  def perform(data)
    Shrine::Attacher.delete(data)
  end
end