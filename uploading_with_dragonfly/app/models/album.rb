class Album < ApplicationRecord
  dragonfly_accessor :image do
    after_assign {|a| a.encode!('jpg', '-quality 90') }
    #copy_to(:image_thumb){|a| a.thumb('250x250#') }
  end
  dragonfly_accessor :image_thumb

  has_many :songs, dependent: :destroy

  validates :title, presence: true
  validates :singer, presence: true
  validates :image, presence: true
  validates_property :width, of: :image, in: (0..900)
end
