module Squibble::AdminCrudAction::New
  extend ActiveSupport::Concern

  included do
    def new(clone_by_id = params[:clone_by_id])
      new! do
        resource.principal = current_principal if resource.respond_to? :principal
        resource.employee = current_employee if resource.respond_to? :employee

        resource.date = Time.zone.today if resource.respond_to? :date

        @page_title = t('helpers.new_resource', model_name: resource_class.model_name.human)

        # Verarbeiten des zu kopierenden Datensatzes
        unless clone_by_id.nil?
          clone_object = get_clone_object(clone_by_id)
          handle_clone_by_object(clone_object)
        end

        __after_new
      end
    end

    private

    def __after_new
    end

    def get_clone_object(clone_by_id)
      resource_class.accessible_by(current_ability).find(clone_by_id)
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end

    def handle_clone_by_object(clone_by_object)
      # Über die Attribute des Clone Objektes iterieren
      # und mit der neuen Ressource verbinden. Dabei werden bestehende
      # Werte überschrieben.
      # Ddas Attribut _id wird nicht überschriben. Handelt es sich
      #
      clone_by_object.attributes.each do |key, value|
        next unless value.present? && key != '_id'
        resource[key] = if value.is_a?(Hash)
                          value[I18n.locale.to_s]
                        else
                          value
                        end
      end
    end
  end
end
