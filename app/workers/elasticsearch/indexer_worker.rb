class Elasticsearch::IndexerWorker
  include Sidekiq::Worker
  include SquibbleService
  sidekiq_options queue: Settings.sidekiq.squibble_elasticsearch,
                  retry: false

  def perform(callback_method, resource_class, operation, resource_id)
    log(:debug, "#{callback_method} performs :#{operation} at #{resource_class} for ##{resource_id}")

    case operation.parameterize.underscore.to_sym
    when :index
      resource = _get_resource(resource_class, resource_id)
      resource.__elasticsearch__.index_document unless resource.nil?
    when :update
      resource = _get_resource(resource_class, resource_id)
      resource.__elasticsearch__.update_document unless resource.nil?
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

  private

  def _get_resource(resource_class, resource_id)
    eval(resource_class).find(resource_id)
  rescue Mongoid::Errors::DocumentNotFound
    msg = "Unable to find #{resource_class} ##{resource_id}"
    log(:error, msg, resource_class: resource_class, resource_id: resource_id)
    return nil
  end
end
