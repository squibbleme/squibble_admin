class App::NavigationDecorator < Draper::Decorator
  def attributes
    {
      class: nav_item_classes,
      data: {
        children: {
          count: object.children.count
        },
        depth: object.depth,
        enabled: nav_item_enabled_path,
        show: can_display_nav?.to_s
      }
    }
  end

  def nav_item_classes
    tmp = ['sq-nav-item', "level-#{object.depth}"]

    tmp << (object.children.empty? ? 'has-no-children' : 'has-children')

    tmp
  end

  def can_display_nav?
    # Es wurde keine Subject Class auf dem Navigationselement
    # hinterlegt.
    #
    if object.subject_class.nil?
      true
    else
      # Es wurde eine Subject Class für das aktuelle Element
      # hinterlegt.
      begin
        h.can? :index, eval(object.subject_class.key)
      rescue NameError
        # Die hinterlegte Subject Class ist aktuell noch nicht
        # im System verfügbar.
        #
        false
      end
    end
  end

  def nav_item_route
    if object.route.present?
      begin
        h.eval(object.route)
      rescue NameError
        "unable to handle #{object.route}"
      end
    else
      'javascript:;'
    end
  end

  def nav_item_enabled_path
    object.enabled_route if object.enabled_route.present?
  end
end