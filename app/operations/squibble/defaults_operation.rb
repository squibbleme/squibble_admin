class Squibble::DefaultsOperation < ComposableOperations::Operation
  require 'csv'

  def execute
    _ensure_acl_permission_action
    _ensure_acl_permission_subject_class
    _ensure_app_navigation
    _ensure_acl_role
    _ensure_application_permissions
  end

  private

  def _ensure_application_permissions
    files = Dir.glob(Rails.root.join('data/import/acl/permissions/*.csv'))
    files.each do |file|
      CSV.foreach(file, headers: :first_row) do |config|
        Squibble::Defaults::Acl::Permission::ConfigToResourceOperation.perform config
      end
    end
  end

  def _ensure_acl_permission_action
    files = Dir.glob(Rails.root.join('data/import/acl/permission/actions/*.csv'))

    files.each do |file|
      CSV.foreach(file, headers: :first_row) do |config|
        begin
          resource = Acl::Permission::Action.find_by( key: config['key'] )
        rescue Mongoid::Errors::DocumentNotFound
          resource = Acl::Permission::Action.new( key: config['key'] )
        end

        resource.label = config['label[de]']
        resource.sort = config['sort'].to_i
        resource.save!
      end
    end
  end

  def _ensure_acl_permission_subject_class
    files = Dir.glob(Rails.root.join('data/import/acl/permission/subject_classes/*.csv'))

    files.each do |file|
      CSV.foreach(file, headers: :first_row) do |config|
        begin
          resource = Acl::Permission::SubjectClass.find_by( key: config['key'] )
        rescue Mongoid::Errors::DocumentNotFound
          resource = Acl::Permission::SubjectClass.new( key: config['key'] )
        end

        resource.label = config['label[de]']
        resource.save!
      end
    end
  end

  def _ensure_acl_role
    files = Dir.glob(Rails.root.join('data/import/acl/roles/*.csv'))

    files.each do |file|
      CSV.foreach(file, headers: :first_row) do |config|
        begin
          resource = Acl::Role.find_by( key: config['key'] )
        rescue Mongoid::Errors::DocumentNotFound
          resource = Acl::Role.new( key: config['key'] )
        end

        resource.label = config['label[de]']
        resource.save!
      end
    end
  end

  def _ensure_app_navigation
    files = Dir.glob(Rails.root.join('data/import/app/navigations/*.csv'))

    files.each do |file|
      CSV.foreach(file, headers: :first_row) do |config|

        begin
          resource = App::Navigation.find_by( translation_key: config['translation_key'] )
        rescue Mongoid::Errors::DocumentNotFound
          resource = App::Navigation.new( translation_key: config['translation_key'] )
        end

        resource.number = config['number']
        resource.route = config['route'] unless config['route'].nil?
        resource.enabled_route = config['enabled_route'] unless config['enabled_route'].nil?
        resource.icon_class = config['icon_class'] unless config['icon_class'].nil?

        # Subject Class
        unless config['subject_class[key]'].nil?
          begin
            subject_class = Acl::Permission::SubjectClass.find_by( key: config['subject_class[key]'] )
          rescue Mongoid::Errors::DocumentNotFound
            msg = "Unable to find subject class Acl::Permission::SubjectClass #{config['subject_class[key]']}"
            fail msg
          else
            resource.subject_class = subject_class
          end
        end

        # Parent Übersetzungsschlüssel
        unless config['parent[translation_key]'].nil?
          begin
            parent = App::Navigation.find_by( translation_key: config['parent[translation_key]'] )
          rescue Mongoid::Errors::DocumentNotFound
            msg = "Unable to find parent App::Navigation #{config['parent[translation_key]']}"
            fail msg
          else
            resource.parent = parent
          end
        end

        resource.save!
      end
    end
  end
end
