class Elasticsearch::IndexOperation < ComposableOperations::Operation
  include SquibbleService

  property :resource_class, required: true, converts: :to_s

  property :resource_id, required: true

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
    @resource = _get_resource
    @resource.__elasticsearch__.index_document
  end

  def _update
    @resource = _get_resource
    @resource.__elasticsearch__.update_document
  end

  def _destroy
    eval_resource_class = eval(resource_class)

    eval_resource_class.__elasticsearch__.client.delete(
      index: eval_resource_class.__elasticsearch__.index_name,
      type: eval_resource_class.__elasticsearch__.document_type,
      id: resource_id
    )
  rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
    msg = "Unable to destroy #{resource_class} [##{resource_id}] search index, because there is none."
    log(:debug, msg, _default_log_attributes)
  end

  def _get_resource
    eval(resource_class).find(resource_id)
  rescue Mongoid::Errors::DocumentNotFound
    msg = "Unable to find #{resource_class} ##{resource_id}."
    log(:debug, msg, _default_log_attributes)
  end

  def _default_log_attributes(options = {})
    tmp = { resource_class: resource_class, resource_id: resource_id }

    tmp[:principal_id] = @resource.principal_id if @resource.present? && @resource.respond_to?(:principal_id)

    tmp.merge(options)
  end
end
