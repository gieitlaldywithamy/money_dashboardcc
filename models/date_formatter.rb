class DateFormatter

  def DateFormatter.us_to_uk(date_string)
    date = Date.strptime(date_string, "%Y-%m-%d")
    uk_date = "#{date.day}/#{date.month}/#{date.year}"
    return uk_date
  end

end
