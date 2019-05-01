class Tag < ApplicationRecord

  has_and_belongs_to_many :albums
  belongs_to :user
  
end
