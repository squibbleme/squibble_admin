module MetaTagsHandler
  extend ActiveSupport::Concern
  included do

    protected
    # Diese Methode kümmert sich darum, dass ein Bild als META Tag
    # gesetzt wird. Durch die Übergabe von :path witd dieser
    # mit dem aktuellen Host zusammengefügt.
    #
    def set_meta_image(path)
      @meta_tags[:'og:image'] = path
      @meta_tags[:'twitter:image'] = path
    end

    def set_meta_site_name(name)
      @meta_tags[:site] = name
      @meta_tags[:'og:site_name'] = name
    end

    def set_meta_title(title)
      @meta_tags[:title] = title
      @meta_tags[:'og:title'] = (title.is_a?(Array) ? title.join(' ') : title)
    end

    def set_meta_locale(locale)
      @meta_tags[:'og:locale'] = locale
    end

    def set_meta_canonical(path)
      @meta_tags[:canonical] = path
      @meta_tags[:'og:url'] = path
    end

    def set_meta_description(description)
      return if description.nil?
      description = ActionView::Base.full_sanitizer.sanitize(description)
                                    .squish

      @meta_tags[:description] = description
      @meta_tags[:'og:description'] = description
    end

    def set_meta_og_type(type)
      @meta_tags[:'og:type'] = type
    end

  end
end
