'use strict'

current_admin_user = {}

jQuery ->

  data = $('meta[name="current_admin_user"]').data()

  current_admin_user =
    id: data['currentAdminUserId']
    email: data['currentAdminUserEmail']
    name: data['currentAdminUserName']
    roles: data['currentAdminUserRoles']

  return


jQuery ->

  $('[data-roles]').each ( index ) ->
    # Zwischenspeichern des gefundenen Elements
    #
    that = $(this)

    # Prüfen, ob die genannten Rollen für den aktuellen
    # Benutzer zur Verfügung stehen.
    #
    list = []

    _.each $(this).data('roles'), ( role ) ->
      list.push _.contains(current_admin_user.roles, role)

    unless _.contains(list, true)
      $(this).remove()

    return
