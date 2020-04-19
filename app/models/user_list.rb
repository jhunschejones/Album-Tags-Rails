class UserList < ApplicationRecord
  belongs_to :user
  belongs_to :list

  LIST_CREATOR = "list_creator".freeze
  USER_LIST_ROLES = [LIST_CREATOR].freeze

  validate :user_list_role_valid

  def user_list_role_valid
    unless USER_LIST_ROLES.include?(role)
      errors.add(:site_role, "not included in '#{USER_LIST_ROLES}'")
    end
  end
end
