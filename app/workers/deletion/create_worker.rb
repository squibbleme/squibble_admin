class Deletion::CreateWorker
  include Sidekiq::Worker
  include SquibbleService
  sidekiq_options queue: :squibble_low,
                  retry: false

  def perform(resource_class, resource_id, principal_id)
    return if [resource_class, resource_id, principal_id].include? nil
    operation = Deletion::CreateOperation.new(
      resource_class: resource_class,
      resource_id: resource_id,
      principal_id: principal_id
    )
    operation.perform
  end
end
