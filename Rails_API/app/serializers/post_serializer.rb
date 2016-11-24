class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  belongs_to :user

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end