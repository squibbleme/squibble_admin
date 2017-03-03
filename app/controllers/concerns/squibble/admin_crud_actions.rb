module Squibble::AdminCrudActions
  extend ActiveSupport::Concern

  included do

    private

  end

  # Diese Methode wird zur Konfiguration des zu verwendenten Partils
  # für die Darstellung auf der Übersichtsseite verwendet.
  #
  # Gültige Werte sind:
  # - :table
  # - :grid
  #
  def list_partial_type
    :table
  end

  def create_tracking(action = params[:action], owner = current_admin_user, options = {})
    if resource.respond_to?(:create_activity)
      resource.create_activity action, owner: owner, area: :admin
    end
  end
end
