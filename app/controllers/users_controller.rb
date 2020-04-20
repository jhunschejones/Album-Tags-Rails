class UsersController < ApplicationController
  def show
    if params[:id] != current_user.id.to_s
      redirect_to user_path(current_user.id), alert: "You cannot view other user's profiles."
    end

    @user = current_user
  end
end
