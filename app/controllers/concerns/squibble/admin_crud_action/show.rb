module Squibble::AdminCrudAction::Show
  extend ActiveSupport::Concern

  included do
    helper_method :show_back_to_overview_path

    def show
      # if stale?(etag: resource, last_modified: resource.updated_at, public: true)
      show! do
        @page_title = resource.to_s
        # @subtitle = resource_class.model_name.human

        __after_show
      end
      # end
    end

    private

    def __after_show
    end

    def _register_show_dashboard(attribute, path = nil)
      @dashboard_show = [] unless @dashboard_show.is_a?(Array)

      @dashboard_show << [resource.send(attribute).count, attribute.to_sym, path]
    end

    def show_back_to_overview_path
      collection_path
    end
  end
end
