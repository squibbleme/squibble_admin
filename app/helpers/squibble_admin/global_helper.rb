module SquibbleAdmin::GlobalHelper
  def today
    Time.zone.today
  end

  def current_quarter
    today.to_date.quarter
  end

  def current_year
    today.year
  end
end
