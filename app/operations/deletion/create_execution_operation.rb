class Deletion::CreateExecutionOperation < ComposableOperations::Operation
  include SquibbleService

  processes :deletion_entry
  property :backend_application_id, required: true

  def execute
    if !deletion_entry.executions.where( backend_application_id: backend_application_id ).exists?

      execution = deletion_entry.executions.build(
        principal_id: deletion_entry.principal_id,
        backend_application_id: backend_application_id
      )

      if execution.save
        log(:debug, "Successfully saved Delection::Exection for Backend::Application ##{backend_application_id}.", _default_log_attributes)
      else
        msg = "Unable to save Deletion::Execution: #{execution.errors.messages}"
        log(:error, msg, _default_log_attributes(errors: execution.errors.messages))
        halt msg
      end
    else
      msg = "There is already a Deletion::Execution for Backend::Application ##{backend_application_id} and this deletion_entry."
      log(:error, msg, _default_log_attributes)
      halt msg
    end
  end

  private

  def _default_log_attributes(options = {})
    {
      principal_id: deletion_entry.principal_id,
      delection_entry_id: deletion_entry.id,
      backend_application_id: backend_application_id
    }.merge(options)
  end
end
