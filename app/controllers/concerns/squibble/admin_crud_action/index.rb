module Squibble::AdminCrudAction::Index
  extend ActiveSupport::Concern

  included do
    def index
      # max_updated_at = collection.max(:updated_at)
      # if stale?( etag: [collection.max(:updated_at), params.except(:action, :controller)], last_modified: max_updated_at, public: true )
      index! do
        __before_index
        @actions_index = [] unless @actions_index.is_a?(Array)

        begin
            _register_index_action(:new, resource_class, new_resource_path(params.except(:action, :controller, :principal_slug)))
          rescue
            NoMethodError
          end
        __after_index

        @scopes_configuration = scopes_configuration
      end
      # end
    end

    private

    def __after_index
    end

    def __before_index
    end

    def _set_actions_index
      @actions_index = []
    end

    def _register_index_action(type, resource_clazz = resource_class, path = new_resource_path)
      return unless can? :create, resource_clazz

      @actions_index << {
        type: type,
        resource_class: resource_clazz,
        path: path
      }
    end
  end
end
