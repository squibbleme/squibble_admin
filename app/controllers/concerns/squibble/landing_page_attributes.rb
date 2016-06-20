module Squibble::LandingPageAttributes

  extend ActiveSupport::Concern

  included do
    def squibble_landing_page_permitted_params
      [
        :headline, :introduction, :subline, :call_to_action_introduction,
        :call_to_action_text, :call_to_action_link, :call_to_action_link_dynamic,
        module_ids: [], squibble_scope: [],
        why_reasons_attributes: [:id, :_destroy, :key, :value, :sort],
        unique_value_propositions_attributes: [:id, :_destroy, :key, :value, :sort]
      ]
    end
  end
end
