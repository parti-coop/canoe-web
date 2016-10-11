module APIHelpers
  def logger
    Rails.logger
  end

  def current_user
    @current_user ||= User.find_by nickname: CGI.unescape(headers['Authorization'] || '')
  end
end
