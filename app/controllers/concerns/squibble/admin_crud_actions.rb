module Squibble::AdminCrudActions
  extend ActiveSupport::Concern

  included do
    include Squibble::AdminCrudAction::Index
    include Squibble::AdminCrudAction::Show

    include Squibble::AdminCrudAction::New
    include Squibble::AdminCrudAction::Create

    include Squibble::AdminCrudAction::Edit
    include Squibble::AdminCrudAction::Update

    include Squibble::AdminCrudAction::Destroy

    private

    # TODO: Entfernen sobald die Übertragung in engine_admin erfolgreich war
    #
    helper_method :form_path, :form_resource_url, :simple_form_resource, :form_back_to_overview_path

    def form_path
      'form'
    end

    def form_back_to_overview_path
      collection_path
    end

    def simple_form_resource(resource)
      [:admin, resource]
    end

    def form_resource_url(resource)
      resource.new_record? ? nil : resource_path(resource.id)
    end
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

  def end_of_association_chain
    if params[:query].present?
      super
    else
      super.backend
    end
  end

  def create_tracking(action = params[:action], owner = current_admin_user, options = {})
    if resource.respond_to?(:create_activity)
      resource.create_activity action, owner: owner, area: :admin
    end
  end
end
