class User < ApplicationRecord

  has_many :tags
  has_many :lists

end
