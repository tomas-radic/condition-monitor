module MeasurementsHelper
  def display_value(value, averaged = false)
    result = value.to_s
    result = "~ #{result} ~" if result.present? && averaged
    result
  end
end
