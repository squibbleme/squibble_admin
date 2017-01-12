module Squibble::AdminCrudAction::Destroy
  extend ActiveSupport::Concern

  included do
    def destroy
      destroy! do |success, _failure|
        redirect_url = params[:_callback_url].present? ? params[:_callback_url] : collection_path

        success.js do
          flash[:notice] = t('flash.actions.destroy.notice', resource_name: resource_class.model_name.human)
          redirect_to redirect_url
        end
        success.html do
          flash[:notice] = t('flash.actions.destroy.notice', resource_name: resource_class.model_name.human)
          redirect_to redirect_url
        end
      end
    end
  end
end
