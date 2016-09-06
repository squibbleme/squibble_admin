class Elasticsearch::IndexerWorker
  include Sidekiq::Worker
  include SquibbleService
  sidekiq_options queue: Settings.sidekiq.squibble_elasticsearch,
                  retry: false

  def perform(callback_method, resource_class, operation, resource_id)
    method = operation.parameterize.underscore.to_sym

    operation = Elasticsearch::IndexOperation.new(
      operation: method,
      resource_class: resource_class,
      resource_id: resource_id
    )
    operation.perform

    return if operation.succeeded?
    log(:error, "Unable to execute Elasticsearch::IndexOperation: #{operation.message}")
  end
end
