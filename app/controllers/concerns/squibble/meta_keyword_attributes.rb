module Squibble::MetaKeywordAttributes

  extend ActiveSupport::Concern

  included do
    def squibble_meta_keywords_permitted_params
      [ :meta_description, meta_keywords: [] ]
    end
  end
end
