namespace :squibble do

  namespace :import do

    desc "SQUIBBLE: Import Defaults"
    task :default => :environment do
      puts "Start importing defaults ..."

      operation = Squibble::DefaultsOperation.new
      operation.perform

      if operation.succeeded?
        puts "Successfully completed".green
      else
        puts "Unable to complete import".red
        puts operation.message
      end
    end
  end
end
