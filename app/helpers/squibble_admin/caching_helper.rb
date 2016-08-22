module SquibbleAdmin::CachingHelper
  def index_collection_cache_key_without_pagination( resource_clazz = resource_class, coll = collection )
    [
      params,
      resource_clazz.to_s,
      coll.count,
      coll.max(:updated_at).to_i
    ]
  end

  def index_collection_cache_key_with_pagination( resource_clazz = resource_class, coll = collection)
    [
      params,
      resource_clazz.to_s,
      coll.total_count,
      coll.max(:updated_at).to_i,
    ]
  end
end
