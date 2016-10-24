module Squibble::AdminExceptionHandling
  extend ActiveSupport::Concern

  included do
    rescue_from CanCan::AccessDenied, with: :_cancan_access_denied
    rescue_from Mongoid::Errors::DocumentNotFound, with: :_mongoid_errors_document_not_found

    rescue_from ActiveModel::MissingAttributeError do |exception|
      render template: 'admin/errors/error_500',
             status: 500, locals: { exception: exception }
    end

    rescue_from NoMethodError do |exception|
      render template: 'admin/errors/error_500',
             status: 500, locals: { exception: exception }
    end

    rescue_from ArgumentError do |exception|
      render template: 'admin/errors/error_500',
             status: 500, locals: { exception: exception }
    end

    private

    def _cancan_access_denied(_exception)
      render template: 'admin/errors/error_401',
             status: 401
    end

    def _mongoid_errors_document_not_found(exception)
      render template: 'admin/errors/error_404',
             status: 404,
             locals: { exception: exception }
    end
  end
end
