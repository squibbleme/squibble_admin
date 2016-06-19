module SquibbleAdmin::Markup::FormatHelper

  def counter_up(value)
    Rails.cache.fetch ['SquibbleAdmin::Markup::FormatHelper.counter_up', value] do
      content_tag(:span, value, :'data-value' => value, :'data-counter' => :counterup)
    end
  end

  def format_quantity(quantity, unit = nil)
    Rails.cache.fetch ['SquibbleAdmin::Markup::FormatHelper.format_quantity', quantity, unit] do
      if unit.nil?
        number_with_precision(quantity, precision: 3, separator: '.', delimiter: ' ', strip_insignificant_zeros: true)
      else
        "#{number_with_precision(quantity, precision: 3, separator: '.', delimiter: ' ', strip_insignificant_zeros: true)} #{unit}"
      end
    end
  end

  def sq_distance(value, unit = :km)
    Rails.cache.fetch ['SquibbleAdmin::Markup::FormatHelper.sq_distance', value, unit] do
      content_tag(:span, "#{number_with_precision(value, precision: 2, separator: '.', delimiter: ' ')} #{unit}", class: 'sq-distance')
    end
  end

  def sq_seconds_to_hours(seconds, format = nil)
    Rails.cache.fetch ['SquibbleAdmin::Markup::FormatHelper.sq_seconds_to_hours', seconds, format] do
      content_tag(:span, seconds, class: 'sq-seconds-to-date', :'data-format' => format, :'data-seconds' => seconds)
    end
  end

  def sq_time(time, format = nil)
    Rails.cache.fetch ['SquibbleAdmin::Markup::FormatHelper.sq_time', time, format] do
      content_tag(:time, (time.present? ? time.to_time : ''), :'data-sq-datetime' => time, class: 'sq-time', :'data-sq-format' => format)
    end
  end

  def sq_distance_to_time(time)
    Rails.cache.fetch ['SquibbleAdmin::Markup::FormatHelper.sq_distance_to_time', time] do
      content_tag(:span, time, :'data-sq-distance-to-time' => time, class: 'sq-distance-to-time')
    end
  end

  def sq_date(date, format = nil)
    Rails.cache.fetch ['SquibbleAdmin::Markup::FormatHelper.sq_date', date, format] do
      content_tag(:date, (date.present? ? date.to_date : ''), :'data-sq-date' => date, class: 'sq-date', :'data-sq-format' => format)
    end
  end

  def sq_price(value)
    Rails.cache.fetch [ 'SquibbleAdmin::Markup::FormatHelper.sq_price', value ] do
      content_tag(:span, value, class: ['sq-price', (value.to_f >= 0.0 ? 'sq-price-positive' : 'sq-price-negative')], :'data-sq-price' => value)
    end
  end

  def true_false_icon(boolean)
    Rails.cache.fetch [ 'SquibbleAdmin::Markup::FormatHelper.true_false_icon', boolean ] do
      if boolean
        content_tag(:i, nil, class: ["font-#{default_green}", 'fa fa-check'])
      else
        content_tag(:i, nil, class: ["font-#{default_red}", 'fa fa-close'])
      end
    end
  end
end
