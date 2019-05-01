class List < ApplicationRecord

  has_and_belongs_to_many :albums
  belongs_to :user

  scope :with_albums, lambda {|query_id| includes(:albums).where(id: query_id).first }
  
end
