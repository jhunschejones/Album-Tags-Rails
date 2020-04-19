class List < ApplicationRecord
  has_many :albums, through: :album_lists
  has_many :users, through: :user_lists

  def creator
    UserList.where(list_id: id, role: UserList::LIST_CREATOR).user
  end
end
