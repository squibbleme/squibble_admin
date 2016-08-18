# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'squibble_admin/version'

Gem::Specification.new do |spec|
  spec.name          = "squibble_admin"
  spec.version       = SquibbleAdmin::VERSION
  spec.authors       = ["Patrick Lehmann"]
  spec.email         = ["lehmann@squibble.me"]

  spec.summary       = 'Squibble Admin'
  spec.description   = 'Squibble Admin Area.'
  spec.homepage      = "http://www.squibble.me"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency('active_link_to')
  spec.add_dependency('carrierwave')
  spec.add_dependency('carrierwave_backgrounder')
  spec.add_dependency('cocoon')
  spec.add_dependency('countries')
  spec.add_dependency('country_select')
  spec.add_dependency('has_scope')
  spec.add_dependency('haml')
  spec.add_dependency('slack-notifier')
  spec.add_dependency('kaminari-mongoid')
  spec.add_dependency('state_machine')
  spec.add_dependency('jquery-rails')
  spec.add_dependency('exception_notification')
  spec.add_dependency('jquery-ui-rails')
  spec.add_dependency('jquery-turbolinks')
  spec.add_dependency('show_for')
  spec.add_dependency('sidekiq')
  spec.add_dependency('sidekiq-cron', '~> 0.4.0')
  spec.add_dependency('simple_form')
  spec.add_dependency('turbolinks', '~> 5.0.0')
end
