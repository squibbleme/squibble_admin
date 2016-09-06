# Erweiterung der Date Klasse um quarter
class Date
  def quarter
    (month / 3.0).ceil
  end
end
