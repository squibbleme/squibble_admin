class AbilityGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def defaults

    @modules = Backend::Module.active.backend
    @roles = Acl::Role.backend

    template 'ability.rb.erb', 'app/models/ability.rb'
  end

end
