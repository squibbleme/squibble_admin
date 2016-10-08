'use strict'

checkEntry = (entry) ->
  entry.data('show')

removeEntry = (entry) ->
  entry.remove()
  return

handleLevel1 = (level_0) ->
  # Prüfung der unterliegenden Level 1. Existieren
  # hier Einträge, die dargestellt werden dürfen?
  #
  level_0.find('li.level-1').each (index) ->
    level_1 = $(this)

    # console.debug "\tPrüfe LVL1: #{s.humanize(level_1.find('>a').text())}"
    if not checkEntry(level_1)
      # Der LVL_1 Eintrag darf nicht dargestellt werden.

      if _.isEqual(level_1.find('li.level-2').length, 0)
        # Es befinden sich KEINE Kindelemente innerhalb des LVL_1
        # Eintrages. Der Eintrag kann aus dem DOM entfernt werden.
        #
        removeEntry(level_1)

    handleLevel2(level_1)
  return

handleLevel2 = (level_1) ->
  level_1.find('li.level-2').each (index) ->
    level_2 = $(this)

    # console.debug "\t\tPrüfe LVL2: #{s.humanize(level_2.find('>a').text())}"
    if not checkEntry(level_2)
      # Entfernen des LVL_2 Eintrages aus DOM, falls dieser nicht angezeigt werden darf.
      #
      removeEntry(level_2)

    # Nachdem die Untergeordneten LVL_2 des aktuellen LVL_1 Eintrages verarbeitet wurden.
    #
    if _.isEqual(level_1.find('li.level-2').length, 0)
      # Es befinden sich nun keine Unterelemente mehr im LVL_1 Eintrag.
      # Der LVL_1 Eintrag kann somit aus dem DOM ebenfalls entfernt werden.
      #
      removeEntry(level_1)
  return
###
  @description  Diese Methode kümmert sich darum, dass die entsprechenden Berechtigungen
                interpretiert und aus dem DOM Entfernt werden.

  @author       Patrick Lehmann <lehmann@squibble.me>
  @date         2016-10-08
  @changelog
                2016-10-08: INIT
###
handlePermissions = ->
  $('#sq-nav-collapse > ul > li.level-0').each (index) ->
    level_0 = $(this)
    # console.debug "Prüfe LVL0: #{s.humanize(level_0.find('>a').text())}"
    handleLevel1(level_0)

    # Das Element verfügte initial über Unterelemente allerdings wurden
    # sämtliche Unterelemente für diesen LVL_0 Eintrag wurden entfernt.
    #
    if level_0.data('childrenCount') > 0 && _.isEqual(level_0.find('li.level-1').length, 0)
      level_0.remove()
  return

###
  @description  Diese Methode kümmert sich um die Aktivierung der aktuell
                aktiven Route innerhalb der Navigation.

  @author       Patrick Lehmann <lehmann@squibble.me>
  @date         2016-10-08
  @changelog
                2016-10-08: INIT
###
handleCurrentActive = ->
  console.log 'current active'
  current_path_name = $(location)[0].pathname
  $('#sq-nav-collapse li.sq-nav-item').removeClass 'active'

  $('#sq-nav-collapse li.sq-nav-item[data-enabled]').each (index) ->
    if s.include(current_path_name, $(this).data('enabled'))
      $(this).addClass 'active'

      $(this).parents('li.sq-nav-item').each (index) ->
        parent = $(this)
        parent.addClass 'active'

        if _.isEqual(parent.data('depth'), 0)
          parent.addClass 'enabled open'

jQuery ->
  handlePermissions()

  handleCurrentActive()
