class ApplicationController < ActionController::Base
  include CanoePathHelper
  include SlackPushing

  protect_from_forgery with: :exception
  after_action :prepare_unobtrusive_flash
  cattr_accessor(:skip_slack) { !Rails.env.production? and ENV["FORCE_SLACK_PUSH"].blank? }

  if Rails.env.production? or Rails.env.staging?
    rescue_from ActiveRecord::RecordNotFound, ActionController::UnknownFormat do |exception|
      render_404
    end
    rescue_from CanCan::AccessDenied do |exception|
      self.response_body = nil
      redirect_to root_url, :alert => exception.message
    end
    rescue_from ActionController::InvalidCrossOriginRequest, ActionController::InvalidAuthenticityToken do |exception|
      self.response_body = nil
      redirect_to root_url, :alert => I18n.t('errors.messages.invalid_auth_token')
    end
  end

  def render_404
    self.response_body = nil
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def errors_to_flash(model)
    flash[:notice] = model.errors.full_messages.join('<br>').html_safe
  end
end
