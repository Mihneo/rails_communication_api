class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :timezone
end
