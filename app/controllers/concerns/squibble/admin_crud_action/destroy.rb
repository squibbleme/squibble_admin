module Squibble::AdminCrudAction::Destroy
  extend ActiveSupport::Concern

  included do
    def destroy
      destroy! do |success, _failure|
        # if resource.respond_to?(:create_activity)
        #   resource.create_activity params[:action], owner: current_admin_user, area: :admin
        # end

        redirect_url = params[:_callback_url].present? ? params[:_callback_url] : collection_path

        success.js do
          flash[:notice] = t('flash.actions.destroy.notice', resource_name: resource_class.model_name.human)
          redirect_to redirect_url, turbolinks: true
        end
        success.html do
          flash[:notice] = t('flash.actions.destroy.notice', resource_name: resource_class.model_name.human)
          redirect_to redirect_url, turbolinks: true
        end
      end
    end
  end
end
