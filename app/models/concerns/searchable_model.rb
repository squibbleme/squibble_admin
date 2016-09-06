module SearchableModel
  extend ActiveSupport::Concern

  included do
    include ::Elasticsearch::Model

    field :sq_search_keywords,
          type: String

    # mapping do
    #   # ...
    # end

    # Temporärer Fix, damit für erbende Klassen der StackLevel ToDeep Error nicht
    # geworfen wird.
    # gem. https://github.com/elastic/elasticsearch-rails/issues/144
    #
    def self.inherited(child)
      super

      child.instance_eval do
        include ::Elasticsearch::Model
      end
    end

    # index document on model touch
    # @see: http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html
    # after_touch() { __elasticsearch__.index_document }

    # def self.search(query)
    ##
    # end

    def resource_class
      self.class.to_s
    end

    def as_indexed_json(_options = {})
      as_json(
        methods: :resource_class,
        except: default_json_excepts.push(custom_json_excepts).flatten.uniq,
        include: custom_json_includes
      )
    rescue NoMethodError => e
      Rails.logger.error "Unable to execute :as_indexed_json: #{e.message}"
    end

    def default_json_excepts
      [:id, :_id, :version, :versions, :created_at, :updated_at]
    end

    def custom_json_excepts
    end

    def custom_json_includes
    end

    scope :simple_query, lambda { |query, filter_terms = nil, options = {}|
      response = if filter_terms.nil?
                   search(query)
                 else
      response = search(
                     query: { match: { _all: query } },
                     filter: { term: filter_terms }
                   )
      end

      response.records
    }

  end

  def self.included(base)
    base.after_touch do |resource|
      Elasticsearch::IndexerWorker.perform_async(:touch, resource.class, :index, resource.id) unless resource.embedded?
    end

    base.after_create do |resource|
      Elasticsearch::IndexerWorker.perform_async(:create, resource.class, :index, resource.id) unless resource.embedded?
    end

    base.after_update do |resource|
      changed_attributes = resource.changed_attributes
      changed_attributes.delete('updated_at')

      if !changed_attributes.empty? && !resource.embedded?
        Elasticsearch::IndexerWorker.perform_async(:update, resource.class, :update, resource.id)
      end
    end

    base.after_destroy do |resource|
      Elasticsearch::IndexerWorker.perform_async(:destroy, resource.class, :destroy, resource.id)

      Deletion::CreateWorker.perform_async(resource.class.to_s, resource.id, resource.principal_id) if resource.respond_to?(:principal_id)
    end
  end
end
