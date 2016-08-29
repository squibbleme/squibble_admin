class Deletion::CreateWorker
  include Sidekiq::Worker
  include SquibbleService
  sidekiq_options queue: Settings.sidekiq.default_queue,
                  retry: false

  def perform(resource_class, resource_id, principal_id)
    operation = Deletion::CreateOperation.new(
      resource_class: resource.class.to_s,
      resource_id: resource.id,
      principal_id: resource.principal_id
    )
    operation.perform

    return if operation.succeeded?
    log(:error, "Unable to execute Deletion::CreateOperation: #{operation.message}")
  end
end
