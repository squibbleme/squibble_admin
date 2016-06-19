module SquibbleAdmin::Markup::CssClassesHelper

  def default_button_classes(additional = nil)
    Rails.cache.fetch ['SquibbleAdmin::Markup::CssClassesHelper.default_button_classes', additional] do
      tmp = ['btn']
      return tmp if additional.nil?

      if additional.is_a?(String)
        tmp << additional
      elsif additional.is_a?(Array)
        tmp = (tmp + additional).uniq
      end

      return tmp
    end
  end

  def hidden_mobile
    %w( hidden-sm hidden-xs )
  end

  def hidden_desktop
    %w( hidden-md hidden-lg )
  end

  def visible_desktop
    %w( visible-md visible-lg )
  end

  def visible_mobile
    %w( visible-sm visible-xs )
  end
end
