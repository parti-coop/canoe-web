class UsersController < ApplicationController
  before_action :authenticate_user!

  def kill_me
    current_user.update_attributes(uid: SecureRandom.hex(10))
    sign_out current_user
    redirect_to root_path
  end
end
