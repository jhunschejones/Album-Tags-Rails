class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,
         :confirmable, :async, :trackable, reconfirmable: true

  encrypts :email, :name
  blind_index :email, :name

  has_many :album_tags, dependent: :destroy
  has_many :album_connections, dependent: :destroy
  has_many :user_lists
  has_many :lists, through: :user_lists

  validates :email, uniqueness: true
  validate :site_role_valid

  SITE_USER = "site_user".freeze
  SITE_ADMIN = "site_admin".freeze
  USER_SITE_ROLES = [SITE_USER, SITE_ADMIN].freeze
  LIST_CREATOR = "list_creator".freeze
  USER_LIST_ROLES = [LIST_CREATOR].freeze

  # --- LIBRARY OVERRIDES FOR SECURITY ---
  # Override default devise method to send emails using active job
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  # This will allow enabling the :trackable Devise module without saving user IPs
  # https://github.com/heartcombo/devise/issues/4849#issuecomment-534733131
  def current_sign_in_ip; end
  def last_sign_in_ip=(_ip); end
  def current_sign_in_ip=(_ip); end

  private

  def site_role_valid
    unless USER_SITE_ROLES.include?(site_role)
      errors.add(:site_role, "not included in '#{USER_SITE_ROLES}'")
    end
  end
end
