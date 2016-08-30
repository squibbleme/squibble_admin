class Elasticsearch::IndexOperation < ComposableOperations::Operation
  include SquibbleService

  property :resource, required: true

  property :operation, converts: :to_sym,
                      accepts: [:index, :update, :destroy],
                      default: :index

  def execute
    case operation
    when :index
      _index
    when :update
      _update
    when :destroy
      _destroy
    end
  end


  private

  def _index
    resource.__elasticsearch__.index_document
  end

  def _update
    resource.__elasticsearch__.update_document
  end

  def _destroy
    resource.class.__elasticsearch__.client.delete(
      index: resource.class.__elasticsearch__.index_name,
      type: resource.class.__elasticsearch__.document_type,
      id: resource.id
    )
  rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
    msg = "Unable to destroy #{resource.class} #{resource.label} [##{resource.id}] search index, because there is none."
    log(:debug, msg, _default_log_attributes)
  end

  def _default_log_attributes(options = {})
    tmp = {
      resource_class: resource.class.to_s,
      resource_id: resource.id
    }

    tmp[:principal_id] = resource.principal_id if resource.respond_to?(:principal_id)
    tmp.merge(options)
  end
end
