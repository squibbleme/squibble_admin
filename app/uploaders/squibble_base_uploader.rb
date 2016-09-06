# encoding: utf-8

class SquibbleBaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::ImageOptimizer
  include CarrierWave::MiniMagick
  include ::CarrierWave::Backgrounder::Delay

  storage :file

  process optimize: [{ quiet: true }]

  def store_dir
    "upload/#{model.class.to_s.underscore}/#{model.principal_id}/#{mounted_as.to_s.pluralize}/#{model.id}"
  end

  # Setzen des Assets Host, damit sämtliche Carrierwave
  # Assets mit dem entsprechenden Host ausgeliefert werden.
  def self.asset_host
    "#{Rails.application.routes.default_url_options[:protocol]}://#{Rails.application.routes.default_url_options[:host]}"
  end
end
