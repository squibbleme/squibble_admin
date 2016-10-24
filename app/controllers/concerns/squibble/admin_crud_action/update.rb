module Squibble::AdminCrudAction::Update
  extend ActiveSupport::Concern

  included do
    def update
      update! do |success, failure|
        __before_update
        success.html do
          __handle_update_success(resource, resource_class)
        end

        failure.html do
          __handle_update_failure(resource, resource_class)
        end

        success.js do
          __handle_update_success(resource, resource_class)
        end

        failure.js do
          __handle_update_failure(resource, resource_class)
        end

        __after_update
      end
    end

    private

    def __after_update
    end

    def __after_update_collection_path
      collection_path
    end

    def __before_update
    end

    def __handle_update_failure(_resource, _resource_class)
      render :edit, change: 'sq_resource:edit'
    end

    def __handle_update_success(_resource, resource_class)
      flash[:notice] = t('flash.actions.update.notice', resource_name: resource_class.model_name.human)

      create_tracking

      redirect_to __after_update_collection_path
    end
  end
end
