module SquibbleAdmin::Admin::Markup::NavigationHelper

  def navigation
    Rails.cache.fetch [ 'SquibbleAdmin::Admin::Markup::NavigationHelper.navigation',
      navigation_current_principal, current_admin_user,
      index_collection_cache_key_without_pagination(App::Navigation, App::Navigation.all)
    ] do
      navigation = App::Navigation.unscoped.roots
                                            .order_by(:path.asc)
                                            .includes(:children, :subject_class)
      render partial: 'helpers/squibble_admin/admin/markup/navigation_helper/navigation',
             locals: { collection: navigation }
    end
  end

  def navigation_current_principal
    self.respond_to?(:current_principal) ? current_principal : nil
  end
end
