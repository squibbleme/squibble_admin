class Deletion::CreateOperation < ComposableOperations::Operation
  include SquibbleService

  property :resource_class, required: true, converts: :to_s
  property :resource_id, required: true
  property :principal_id, required: true

  property :message

  def execute
    subject_class = _get_acl_permission_subject_class
    principal = _get_backend_principal

    deletion = Deletion::Entry.new(
      principal_id: principal.id,
      subject_class_id: subject_class.id,
      resource_id: resource_id,
      internal_description: message
    )

    if deletion.save
      log(:debug, "Successfully created Deletion::Entry ##{deletion.id} for #{subject_class.key} ##{resource_id}.", _default_log_attributes)
    else
      msg = "Unable to create Deletion::Entry: #{deletion.errors.messages}."
      log(:error, msg, _default_log_attributes(errors: deletion.errors.messages))
      halt msg
    end
  end

  private

  def _default_log_attributes(options = {})
    {
      resource_class: resource_class,
      sq_resource_id: resource_id,
      principal_id: principal_id
    }.merge!(options)
  end

  def _get_acl_permission_subject_class
    Acl::Permission::SubjectClass.find_by( key: resource_class )
  rescue Mongoid::Errors::DocumentNotFound
    msg = "Unable to find Acl::Permission::SubjectClass for #{resource_class}."
    log(:error, msg, _default_log_attributes)
    halt msg
  end

  def _get_backend_principal
    Backend::Principal.find( principal_id )
  rescue Mongoid::Errors::DocumentNotFound
    msg = "Unable to find Backend::Principal for #{principal_id} to create a #{resource_class} deletion."
    log(:error, msg, _default_log_attributes )
    halt msg
  end

end
