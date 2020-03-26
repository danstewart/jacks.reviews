class User < ApplicationRecord
  validates_presence_of :name, :email

  # TODO: Permissions system
  def can_access(item)
    return 1
  end
end
