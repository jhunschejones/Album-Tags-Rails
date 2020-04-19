class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # Overwriting the sign_out redirect path method in devise
  # https://github.com/heartcombo/devise/wiki/How-To:-Change-the-redirect-path-after-destroying-a-session-i.e.-signing-out
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
