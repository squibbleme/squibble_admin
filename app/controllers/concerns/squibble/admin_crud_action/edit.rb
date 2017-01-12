module Squibble::AdminCrudAction::Edit
  extend ActiveSupport::Concern

  included do
    def edit
      edit! do
        __before_edit

        @page_title = resource.to_s
        @subtitle = t('helpers.edit_resource', model_name: resource_class.model_name.human)

        __after_edit
      end
    end

    private

    def __after_edit; end

    def __before_edit; end
  end
end
