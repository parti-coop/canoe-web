class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  prepend_before_filter :require_no_authentication, only: [:facebook, :twitter, :naver]

  def facebook
    if request.env["omniauth.auth"].info.email.blank?
      redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email" and return
    end

    run_omniauth
  end

  def twitter
    run_omniauth
  end

  def naver
    run_omniauth
  end

  def failure
    redirect_to root_path
  end

  private

  def run_omniauth
    parsed_data = User.parse_omniauth(request.env["omniauth.auth"])
    remember_me = request.env["omniauth.params"].try(:fetch, "remember_me", false)
    parsed_data[:remember_me] = remember_me
    @user = User.find_or_initialize_for_omniauth(parsed_data)
    if @user.new_record?
      if @user.save
        set_flash_message(:notice, :success_join) if is_navigational_format?
      else
        set_flash_message(:notice, :failure, kind: @user.provider, reason: @user.errors.full_messages.to_sentence) if is_navigational_format?
        redirect_to root_path and return
      end
    else
      @user.remember_me = remember_me
      set_flash_message(:notice, :success_login, kind: @user.provider) if is_navigational_format?
    end
    sign_in_and_redirect @user, :event => :authentication
  end
end
