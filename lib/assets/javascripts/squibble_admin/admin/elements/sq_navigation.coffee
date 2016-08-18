'use strict'

$(document).on 'ready', (event) ->
  # handleNavigationPermissions()

  $('.sq-nav-item.level-0').each ( index ) ->
    level_0 = $(this)

    # Das data-show Attribute ist gesetzt
    #
    if !_.isUndefined(level_0.data().show)

      # Das Element verfügt über keine untergeordnete
      # Navigationselemente.
      #
      # Das Navigationselement verfügt über keine unterliegenden Navigationspunkte
      #
      if _.isEqual(level_0.find('ul.sq-dropdown-level-1').length, 0)
        level_0.removeClass 'display-none'

      # Das Navigationselement verfügt über unterliegende Navigationspunkte
      # und mindestens einer dieser Navigationspunkte verfügt über ein
      # data-show Attribut und muss somit dargestellt werden.
      #
      else
        if level_0.find('.sq-nav-item[data-show]').length > 0
          level_0.removeClass 'display-none'

          # Überprüfen der Elemente auf Level 1
          #
          level_0.find('.sq-nav-item.level-1').each ( index ) ->
            level_1 = $(this)

            # Das data-show Attribut ist gesetzt
            #
            if !_.isUndefined(level_1.data().show)

              # Das Navigationselement verfügt über keine unterliegenden
              # Navigationspunkte.
              #
              if _.isEqual(level_1.find('ul.sq-dropdown-level-2').length, 0)
                level_1.removeClass 'display-none'

              else
                # Das Element verfügt über mindestens ein Unterelement,
                # dass dargestellt werden soll.
                #
                if level_1.find('.sq-nav-item[data-show]').length > 0
                  level_1.removeClass 'display-none'

                  # Überprüfen der Elemente auf Level 2
                  #
                  level_1.find('.sq-nav-item.level-2').each ( index ) ->
                    level_2 = $(this)

                    # Das data-show Attribut ist gesetzt
                    #
                    if !_.isUndefined(level_2.data().show)
                      level_2.removeClass 'display-none'


jQuery ->
  handleNavigation()



handleNavigation = ->
  pathname = $(location)[0].pathname

  # Handhabung der Darstellung der Einträge, die den aktuellen
  # Berechtigungen entsprechen.
  #
  # Laden der :role_keys und der :module_keys
  # current_admin_user_role_keys = $('meta[name="current_admin_user"]').data().currentAdminUserRoles
  # current_principal_module_keys = $('meta[name="current_principal"]').data().currentPrincipalModules


  # Deaktivieren der Navigationseinträge
  $('nav.navbar li.dropdown-fw, nav.navbar li.more-dropdown-sub, nav.navbar li.dropdown-menu-item')
    .removeClass 'active'

  $('nav.navbar li.dropdown-menu-item[data-enabled]').each ( nav_item ) ->

    if s.include(pathname, $(this).data('enabled'))

      # Unterste Ebene: Aktivieren des eigentlichen Elementes
      #
      $(this).addClass 'active'

      # Mittlere Ebene: Aktivieren der Überschrift
      #
      $(this).closest 'li.more-dropdown-sub'
        .addClass 'active'

      # Oberste Ebene: Aktivieren der Lasche
      #
      $(this).closest 'li.dropdown-fw'
        .addClass 'active enabled open'

  return
