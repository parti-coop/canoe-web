class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:kill_me]

  def kill_me
    current_user.update_attributes(uid: SecureRandom.hex(10))
    sign_out current_user
    redirect_to root_path
  end
end
