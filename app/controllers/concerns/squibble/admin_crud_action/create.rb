module Squibble::AdminCrudAction::Create
  extend ActiveSupport::Concern

  included do
    def create
      create! do |success, failure|
        success.html do
          __handle_create_success(resource, resource_class)
        end

        failure.html do
          __handle_create_failure(resource, resource_class)
        end

        success.js do
          __handle_create_success(resource, resource_class)
        end

        failure.js do
          __handle_create_failure(resource, resource_class)
        end
      end
    end

    private

    def __after_create_collection_path
      collection_path
    end

    def __handle_create_success(_resource, resource_class)
      __handle_create_success_callback

      flash[:notice] = t('flash.actions.create.notice', resource_name: resource_class.model_name.human)

      redirect_to after_create_success_path
    end

    def __handle_create_success_callback; end

    def __handle_create_failure(_resource, _resource_class)
      __handle_create_failure_callback

      render :new, change: 'sq_resource:new',
                   status: 400
    end

    def __handle_create_failure_callback; end

    # Internal Helper Methods
    #
    def after_create_success_path
      if params[:_callback_url].present?
        params[:_callback_url]
      else
        if params[:_add_another]
          new_resource_path
        elsif params[:_add_edit]
          edit_resource_path(resource._id)
        else
          __after_create_collection_path
        end
      end
    end
  end
end
