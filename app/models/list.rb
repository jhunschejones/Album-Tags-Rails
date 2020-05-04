class List < ApplicationRecord
  has_and_belongs_to_many :albums
  has_many :users, through: :user_lists

  def creator
    UserList.where(list_id: id, role: UserList::LIST_CREATOR).user
  end
end
