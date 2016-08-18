class CsvRelationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  argument :relation, type: :string, default: nil

  def generate_defaults
    @name = name
    @relation = relation
    @operation_base_path = File.join("app/operations/#{name.underscore}/data_handling")
  end

  def create_collection_to_csv_operation
    collection_to_csv_operation_path = File.join(@operation_base_path, 'collection_to_csv_operation.rb')
    template 'operations/collection_to_csv_operation.rb.erb', collection_to_csv_operation_path
  end

  def create_csv_entry_operation
    csv_entry_operation_path = File.join(@operation_base_path, 'csv_entry_operation.rb')
    template 'operations/csv_entry_operation.rb.erb', csv_entry_operation_path
  end

  def create_csv_relation_operation
    csv_relation_operation_path = File.join(@operation_base_path, 'csv_relation_operation.rb')
    template 'operations/csv_relation_operation.rb.erb', csv_relation_operation_path
  end
end
