module APIDefaults
  extend ActiveSupport::Concern

  included do
    default_format :json
    format :json
    use GrapeLogging::Middleware::RequestLogger,
      instrumentation_key: 'grape_key',
      include: [ GrapeLogging::Loggers::Response.new,
                 GrapeLogging::Loggers::ClientEnv.new,
                 GrapeLogging::Loggers::RequestHeaders.new,
                 GrapeLogging::Loggers::FilterParameters.new ]

    rescue_from ActiveRecord::RecordNotFound do |e|
      logger.info "404"
      error!(e.message, 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      logger.info "422"
      error!(e.message, 422)
    end

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      logger.info "400"
      error!(e.message, 400)
    end

    rescue_from ::CanCan::AccessDenied do |e|
      error!(e.message, 403)
    end

    unless Rails.env.development?
      rescue_from :all do |e|
        logger.info "500"
        error!(e.message, 500)
      end
    end
  end
end
