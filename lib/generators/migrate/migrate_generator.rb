class MigrateGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_operation
    operation_root_path = Rails.root.join('app/operations/migrate')
    FileUtils.mkdir_p(operation_root_path) unless File.exists?(operation_root_path)

    timestamp = Time.zone.now.strftime('%Y%m%d_%H%M%S%L')

    # Generieren der Namern
    #
    name_numbers = []
    name.split('').each do |number|
      name_numbers << I18n.with_locale(:en) { number.to_i.to_words }
    end

    operation_file_name = "issue_#{name_numbers.join('_')}_operation.rb"

    @operation_class_name = "Migrate::Issue#{name_numbers.map{|r| r.classify }.join('')}Operation"
    @name = name

    template 'operation.rb.erb', File.join(operation_root_path, operation_file_name)

    puts "Copy to db/seeds.rb: operation = #{@operation_class_name}.perform()".light_blue
  end
end
