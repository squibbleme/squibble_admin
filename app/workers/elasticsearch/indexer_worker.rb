class Elasticsearch::IndexerWorker
  include Sidekiq::Worker
  include SquibbleService
  sidekiq_options queue: Settings.sidekiq.squibble_elasticsearch,
                  retry: false

  def perform(callback_method, resource_class, operation, resource_id)
    resource = _get_resource(resource_class, resource_id, method)

    method = operation.parameterize.underscore.to_sym
    operation = Elasticsearch::IndexOperation.new( resource: resource, operation: method )
    operation.perform

    return if operation.succeeded?
    log(:error, "Unable to execute Elasticsearch::IndexOperation: #{operation.message}")
  end

  private

  def _get_resource(resource_class, resource_id, method)
    eval(resource_class).find(resource_id)
  rescue Mongoid::Errors::DocumentNotFound
    msg = "Unable to find #{resource_class} ##{resource_id} for :#{method}"
    log(:error, msg, resource_class: resource_class, resource_id: resource_id, method: method)
    return nil
  end
end
