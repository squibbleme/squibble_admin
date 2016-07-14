module SearchableController
  extend ActiveSupport::Concern
  include SquibbleService

  included do
    has_scope :query do |controller, scope, value|
      search_request = Search::Request::AdminUser.new(
        query: value,
        params: controller.params,
        admin_user_id: controller.current_admin_user.id
      )
      search_request.save!

      scope.simple_query( value )
    end

    rescue_from Elasticsearch::Transport::Transport::Errors::NotFound do |exception|
      log(:error, "Error while doing a search query: #{exception.message}",
        params: params,
        exception: exception.message
      )

      render template: 'admin/errors/error_search',
             status: 500,
             locals: {
               exception: exception
             }
    end
  end
end
