module ApplicationHelper
  def formatted_date(date)
    result = ''
    return result if date.nil?

    case date
    when Date.today
      result += t('dates.today')
    when Date.tomorrow
      result += t('dates.tomorrow')
    else
      result += t("dates.days.#{date.strftime('%A').downcase}")
      result += date.strftime(', %-d ')
      result += t("dates.months.#{date.strftime('%B').downcase}")
    end
    
    result
  end

  def formatted_datetime(datetime)
    result = ''
    return result if datetime.nil?
    date = Date.parse(datetime.to_s)

    case date
    when Date.today
      result += t('dates.today')
    when Date.tomorrow
      result += t('dates.tomorrow')
    else
      result += t("dates.days.#{date.strftime('%A').downcase}")
      result += date.strftime(', %-d ')
      result += t("dates.months.#{date.strftime('%B').downcase}")
    end

    result += datetime.strftime(' %k:%M:%S')
    result
  end

  def switch_locale_link
    redirect_path = root_path
    caption = 'Default language'
    
    case I18n.locale
    when :en
      redirect_path = root_path locale: :sk
      caption = t('.slovak')
    when :sk
      redirect_path = root_path locale: :en
      caption = t('.english')
    end

    link_to caption, redirect_path
  end
end
