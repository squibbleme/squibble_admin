module SquibbleAdmin::Markup::CssClassesHelper

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
