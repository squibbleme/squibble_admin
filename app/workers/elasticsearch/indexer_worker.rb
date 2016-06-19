class Elasticsearch::IndexerWorker
  include Sidekiq::Worker
  include SquibbleService
  sidekiq_options queue: Settings.sidekiq.default_queue,
                  retry: false

  def perform(callback_method, resource_class, operation, resource_id)
    log(:debug, "#{callback_method} performs :#{operation} at #{resource_class} for ##{resource_id}")

    case operation.parameterize.underscore.to_sym
    when :index
      resource = eval(resource_class).find(resource_id)
      resource.__elasticsearch__.index_document
    when :update
      resource = eval(resource_class).find(resource_id)
      resource.__elasticsearch__.update_document
    when :destroy
      begin
        eval(resource_class).__elasticsearch__.client.delete(
          index: eval(resource_class).__elasticsearch__.index_name,
          type: eval(resource_class).__elasticsearch__.document_type,
          id: resource_id
        )
      rescue Elasticsearch::Transport::Transport::Errors::NotFound
        log(:error, "Unable to find elasticsearch index for #{resource_class} ##{resource_id} to delete.")
      end
    else
      log(:error, "Unregistered operation #{operation} called.")
    end
  end
end
